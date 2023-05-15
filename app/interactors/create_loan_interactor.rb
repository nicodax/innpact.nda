# frozen_string_literal: true

class CreateLoanInteractor
  include Interactor

  def call
    Loan.transaction do
      create_loan
      send_notifications
    rescue StandardError => e
      context.error = I18n.t('loans.create.internal_error')
      Rails.logger.info "Create loan error: #{e.inspect}"
      context.fail!
    end
  end

  delegate :fund, :params, :user, :loan, to: :context

  private

  def create_loan
    loan_validator = LoanValidator.new.call(loan_params)
    loan_version_validator = InitialLoanVersionValidator.new.call(loan_version_params)
    context.loan = fund.loans.build(loan_params.merge({ innpact_loan_id: last_innpact_loan_id + 1 }))
    context.loan.loan_sdg_data.build(loan_sdg_data_params)
    context.loan.presentation_compliance_checks.build(presentation_compliance_check_params)
    loan_version = context.loan.build_new_version(loan_version_params)
    compliant_pool = compliant_pool?(loan_version)
    if loan_validator.success? && loan_version_validator.success? && compliant_pool
      loan.save!
    else
      unless compliant_pool
        loan_version.errors.add(:pool_id, I18n.t('loan_versions.validation.pool_not_compliant'))
      end
      # rubocop:disable Rails/DeprecatedActiveModelErrorsMethods
      # Not ActiveModel::Errors
      loan_validator.errors.to_h.each do |k, v|
        loan.errors.add(k, v.first)
      end
      loan_version_validator.errors.to_h.each do |k, v|
        loan_version.errors.add(k, v.first)
      end
      # rubocop:enable Rails/DeprecatedActiveModelErrorsMethods
      context.fail!(error: I18n.t('loans.create.error', loan_errors: loan.errors.full_messages.join(', ')))
    end
  end

  def loan_params
    params
      .except(:loan_version, :loan_sdg_data, :presentation_compliance_check)
      .merge(creation_user_id: user.id,
             fund_id: fund.id,
             institution_mode_at_creation: institution_mode).to_h
  end

  def loan_version_params
    status = if institution_mode == Loan::NEW_INSTITUTION_MODE
               LoanVersion::STATUS_ASSIGNED
             else
               LoanVersion::STATUS_APPETITE_INQUIRY
             end

    params[:loan_version].try(:merge, { creation_user_id: user.id,
                                        version_status: LoanVersion::VERSION_STATUS_VALIDATED,
                                        status: status,
                                        validation_user_id: user.id }).to_h
  end

  def loan_sdg_data_params
    params.fetch(:loan_sdg_data, nil)
  end

  def presentation_compliance_check_params
    params.fetch(:presentation_compliance_check, nil)
  end

  def institution_mode
    @institution_mode ||= Institution.find(params[:institution_id]).invested? ? Loan::INVESTED_INSTITUTION_MODE : Loan::NEW_INSTITUTION_MODE
  end

  def compliant_pool?(loan_version)
    pool = loan_version.pool

    return false if pool.blank?
    return true unless pool.is_targeted

    statuses = []

    if pool.pool_institutions.any?
      statuses.push(pool.pool_institutions.exists?(institution_id: loan_version.loan.institution.id))
    end

    if pool.pool_currencies.any?
      statuses.push(pool.pool_currencies.exists?(currency_id: loan_version.currency.id))
    end

    if pool.loan_types.any?
      statuses.push(pool.pool_loan_types.exists?(loan_type_id: loan_version.loan_type.id))
    end

    statuses.all?
  end

  def send_notifications
    managers = User.with_any_role(User::ROLE_ADMINISTRATOR, User::ROLE_GENERAL_MANAGER)
    ims = context.loan.im_group.users

    creating_user_is_admin = user.administrator? || user.general_manager?

    managers.each do |manager|
      next if manager == user

      if creating_user_is_admin
        LoanMailer.loan_creation_without_validation_link(context.loan.id, manager).deliver_later
      else
        LoanMailer.loan_creation_with_validation_link(context.loan.id, manager).deliver_later
      end
    end

    ims.each do |im|
      next if im == user

      if im.user_setting.allows_loans_crud_mail?
        LoanMailer.loan_creation_without_validation_link(context.loan.id, im).deliver_later
      end
    end
  end

  def last_innpact_loan_id
    Loan.with_deleted.maximum(:innpact_loan_id)
  end
end
