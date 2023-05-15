# frozen_string_literal: true

class UpdateLoanInteractor
  include Interactor

  def call
    Loan.transaction do
      update_loan
      send_notifications
    rescue Interactor::Failure => e
      context.fail!(error: e.context.error)
    rescue ActiveRecord::RecordInvalid => e
      context.fail!(error: e.record.errors.full_messages)
    rescue StandardError => e
      ActiveSupport::Notifications.instrument 'exception.interactors',
                                              exception: e,
                                              interactor: :update_loan,
                                              backtrace: e.backtrace

      context.fail!(error: I18n.t('loans.update.error'), exception: e, backtrace: e.backtrace)
    end
  end

  delegate :params, :loan, :user, to: :context

  private

  attr_reader :valid_loan, :repayment_calendar, :loan_provision

  def update_loan
    new_status = loan_version_params[:status]
    loan.loan_sdg_data.build(params.fetch(:loan_sdg_data, nil))
    loan.presentation_compliance_checks.build(params.fetch(:presentation_compliance_check, nil))
    new_version = loan.build_new_version(loan_version_params)
    new_version_attributes_with_hedge = new_version.attributes.merge(hedge_checkbox: loan_version_params[:hedge_checkbox])
    loan_version_validator = validators[new_status].call(new_version_attributes_with_hedge)
    @valid_loan = loan_version_validator.success?

    # rubocop:disable Rails/DeprecatedActiveModelErrorsMethods
    # Not ActiveModel::Errors
    loan_version_validator.errors.to_h.each { |k, v| loan.active_loan_version.errors.add(k, v.first) }
    # rubocop:enable Rails/DeprecatedActiveModelErrorsMethods
    context.fail!(error: loan.active_loan_version.errors.full_messages) unless valid_loan

    compliant_pool = compliant_pool?(new_version)
    context.fail!(error: I18n.t('loans.update.empty_repayment_calendar')) if new_status == LoanVersion::STATUS_INVESTED && repayment_calendar_params.empty?
    build_new_repayment_calendar(new_version, new_status)

    context.fail!(error: repayment_calendar.errors.full_messages) if repayment_calendar&.invalid?

    if valid_loan && (repayment_calendar.nil? || repayment_calendar.valid?) && compliant_pool
      loan.save!
      repayment_calendar.try(:save!)
      if repayment_calendar.present?
        create_calendar_log_lines
      end
      loan_provision.try(:save!)
    else
      if !compliant_pool
        loan.active_loan_version.errors.add(:pool_id, I18n.t('loan_versions.validation.pool_not_compliant'))
      end
      context.fail!(error: loan.active_loan_version.errors)
    end
  end

  def build_new_repayment_calendar(new_version, new_status)
    @repayment_calendar = nil
    return if new_status != LoanVersion::STATUS_INVESTED

    @repayment_calendar = new_version.build_new_repayment_calendar(repayment_calendar_params.except(:repayment_calendar_lines_attributes))
    repayment_calendar_params[:repayment_calendar_lines_attributes].each_value do |value|
      @repayment_calendar.repayment_calendar_lines.build(value.except(:id, :_destroy))
    end

    repayment_lines_to_provision = repayment_calendar.repayment_calendar_lines.select do |rl|
      rl.repayment_type == RepaymentCalendarLine::REPAYMENT_TYPE_PRINCIPAL &&
        rl.status == RepaymentCalendarLine::STATUS_PENDING
    end

    provision_amount = repayment_lines_to_provision.sum(&:provision)

    if repayment_lines_to_provision.any? && provision_amount.positive?
      provision_percentage = nil
      previous_amount_of_provision = 0
      new_amount_of_provision = provision_amount
    else
      provision_percentage = loan.institution.current_provision_percentage
      previous_amount_of_provision = loan.provision_amount || 0
      new_amount_of_provision = repayment_calendar.temp_gross_amount * provision_percentage

      repayment_lines_to_provision.each do |repayment_line|
        repayment_line.provision = repayment_line.original_amount * provision_percentage
      end
    end

    @loan_provision = LoanProvision.new(
      percentage: provision_percentage,
      amount: new_amount_of_provision,
      previous_amount_of_provision: previous_amount_of_provision,
      new_amount_of_provision: new_amount_of_provision,
      loan: loan,
      creation_user: user,
      repayment_calendar: repayment_calendar
    )

    update_monetary_values(new_version)
  end

  def create_calendar_log_lines
    repayment_calendar.repayment_calendar_lines.each do |line|
      @repayment_calendar.calendar_log.lines << CalendarLogLine.new(
        new_repayment_line_id: line.id,
        action: CalendarLogLine::ACTION_CREATION
      )
    end
  end

  def update_monetary_values(new_version)
    gross_position_value = repayment_calendar.temp_gross_amount
    new_version.gross_position_value = gross_position_value
    provision_value = repayment_calendar.temp_provision_amount
    new_version.provision_value = provision_value.positive? ? provision_value : @loan_provision.amount
    new_version.net_position_value = gross_position_value - new_version.provision_value
  end

  def send_notifications
    return unless valid_loan

    managers = User.with_any_role(User::ROLE_ADMINISTRATOR, User::ROLE_GENERAL_MANAGER)
    ims = context.loan.im_group.users

    managers.each do |manager|
      next if manager == user

      if user.administrator? || user.general_manager?
        LoanMailer.loan_update_without_validation_link(context.loan.active_loan_version.id, manager).deliver_later
      else
        LoanMailer.loan_update_with_validation_link(context.loan.active_loan_version.id, manager).deliver_later
      end
    end

    ims.each do |im|
      next if im == user

      LoanMailer.loan_update_without_validation_link(context.loan.active_loan_version.id, im).deliver_later
    end
  end

  def validators
    {
      LoanVersion::STATUS_ASSIGNED => InitialLoanVersionValidator.new,
      LoanVersion::STATUS_APPETITE_INQUIRY => InitialLoanVersionValidator.new,
      LoanVersion::STATUS_PENDING_RATIFICATION => PendingRatificationLoanVersionValidator.new,
      LoanVersion::STATUS_RATIFIED => RatifiedLoanVersionValidator.new,
      LoanVersion::STATUS_NOT_RATIFIED => InitialLoanVersionValidator.new,
      LoanVersion::STATUS_NOT_VALIDATED => InitialLoanVersionValidator.new,
      LoanVersion::STATUS_ASSIGNMENT_EXPIRED => InitialLoanVersionValidator.new,
      LoanVersion::STATUS_RELEASED_BEFORE_APPROVAL => InitialLoanVersionValidator.new,
      LoanVersion::STATUS_PENDING_APPROVAL => PendingApprovalLoanVersionValidator.new,
      LoanVersion::STATUS_APPROVED => ApprovedLoanVersionValidator.new,
      LoanVersion::STATUS_NOT_APPROVED => RatifiedLoanVersionValidator.new,
      LoanVersion::STATUS_APPROVAL_EXPIRED => RatifiedLoanVersionValidator.new,
      LoanVersion::STATUS_APPROVED_CHANGE_REQUEST => ApprovedChangeRequestLoanVersionValidator.new,
      LoanVersion::STATUS_INVESTED => InvestedLoanVersionValidator.new,
      LoanVersion::STATUS_MATURED => MaturedLoanVersionValidator.new,
      LoanVersion::STATUS_RELEASED_AFTER_APPROVAL => ApprovedLoanVersionValidator.new,
    }
  end

  def loan_version_params
    params[:loan_version].try(:merge, { creation_user_id: user.id }).try(:merge, versioning_params).to_h
  end

  def versioning_params
    if user.administrator? || user.general_manager? || user.system?
      { version_status: LoanVersion::VERSION_STATUS_VALIDATED, validation_user: user }
    else
      { version_status: LoanVersion::VERSION_STATUS_TEMPORARY, validation_user: nil }
    end
  end

  def repayment_calendar_params
    params[:repayment_calendar].try(:merge, { creation_user_id: user.id }).try(:merge, versioning_params).to_h
  end

  def compliant_pool?(loan_version)
    pool = loan_version.pool

    return true unless loan_version.pool.is_targeted

    statuses = []

    if pool.pool_institutions.any?
      statuses.push(pool.pool_institutions.where(institution_id: loan_version.loan.institution.id).exists?)
    end

    if pool.pool_currencies.any?
      statuses.push(pool.pool_currencies.where(currency_id: loan_version.currency.id).exists?)
    end

    if pool.loan_types.any?
      statuses.push(pool.pool_loan_types.where(loan_type_id: loan_version.loan_type.id).exists?)
    end

    statuses.all?
  end
end
