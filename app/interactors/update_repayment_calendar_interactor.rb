# frozen_string_literal: true

class UpdateRepaymentCalendarInteractor
  include Interactor
  def call
    RepaymentCalendar.transaction do
      get_calendar
      create_new_loan_version
      create_new_calendar_version
      check_for_critical_case
      create_loan_provisions
      update_monetary_values
      validate_changes
      create_calendar_logs
      # https://innpact.atlassian.net/browse/MEF-763
      # This is a workaround to the fact that https://github.com/belighted/innpact/pull/232 was put in production
      # before MEF-763 was approved.
      # update_maturity_date
      send_notifications
    rescue StandardError => e
      context.fail!
    end
  end

  delegate :loan, :user, :params, :repayment_calendar, to: :context

  attr_reader :new_repayment_calendar, :calendar_log, :loan_provision, :new_loan_version

  private

  def get_calendar
    context.repayment_calendar = loan.active_repayment_calendar
  end

  def validate_changes
    if new_repayment_calendar.valid? && (loan_provision.nil? || loan_provision.valid?)
      new_repayment_calendar.save!
      loan.save!
      loan_provision.try(:save!)
      context.repayment_calendar = new_repayment_calendar
    else
      repayment_calendar.assign_attributes(merged_repayment_attributes)
      repayment_calendar.valid?
      if loan_provision && !loan_provision.valid?
        repayment_calendar.errors.add(:base, loan_provision.errors.full_messages.join(','))
      end
      context.repayment_calendar = repayment_calendar
      context.fail!(error_message: 'Validation error')
    end
  end

  def create_new_loan_version
    @new_loan_version = loan.build_new_version(versioning_params)
  end

  def create_new_calendar_version
    @new_repayment_calendar = new_loan_version.build_new_repayment_calendar(filtered_merged_repayment_attributes)
  end

  def check_for_critical_case
    restructuring_line = new_repayment_calendar.repayment_calendar_lines
                                               .detect { |line| RepaymentCalendarLine.critical_case?(line) }

    loan.restructuring = restructuring_line.present? ? true : false
  end

  def create_calendar_logs
    @calendar_log = new_repayment_calendar.calendar_log
    repayment_calendar.repayment_calendar_lines.each do |line|
      if line.previous_version_line_id.nil?
        calendar_log.lines << CalendarLogLine.new(
          new_repayment_line_id: line.id,
          action: CalendarLogLine::ACTION_CREATION
        )
      else
        previous_line = line.previous_version_line
        repayment_line_attributes.each do |attribute|
          if previous_line.send(attribute) != line.send(attribute)
            calendar_log.lines << CalendarLogLine.new(
              new_repayment_line_id: line.id,
              original_repayment_line_id: previous_line.id,
              changed_attribute: attribute,
              action: CalendarLogLine::ACTION_UPDATE,
              original_value: previous_line.send(attribute).is_a?(Date) ? previous_line.send(attribute).strftime('%d-%m-%Y') : previous_line.send(attribute),
              new_value: line.send(attribute).is_a?(Date) ? line.send(attribute).strftime('%d-%m-%Y') : line.send(attribute)
            )
          end
        end
      end
    end

    calendar_log.save!
  end

  def create_loan_provisions
    @loan_provision = nil
    new_amount_of_provision = new_repayment_calendar.temp_provision_amount
    previous_amount_of_provision = repayment_calendar.provision_amount

    if new_amount_of_provision != previous_amount_of_provision

      @loan_provision = LoanProvision.new(
        percentage: nil,
        amount: new_amount_of_provision - previous_amount_of_provision,
        previous_amount_of_provision: previous_amount_of_provision,
        new_amount_of_provision: new_amount_of_provision,
        loan: loan,
        creation_user: user,
        repayment_calendar: new_repayment_calendar
      )

      new_loan_version.provision_date = Date.today
    end
  end

  def update_monetary_values
    gross_position_value = new_repayment_calendar.temp_gross_amount
    new_loan_version.gross_position_value = gross_position_value
    provision_value = new_repayment_calendar.temp_provision_amount
    new_loan_version.provision_value = provision_value
    new_loan_version.net_position_value = gross_position_value - provision_value
  end

  def send_notifications
    return unless repayment_calendar.valid?

    admin_and_managers = User.with_any_role(User::ROLE_ADMINISTRATOR, User::ROLE_GENERAL_MANAGER)
    ims = context.loan.im_group.users

    admin_and_managers.each do |admin_and_manager|
      next if admin_and_manager == user

      if user.administrator? || user.general_manager?
        RepaymentCalendarMailer.repayment_calendar_update_without_validation_link(context.repayment_calendar.id, admin_and_manager).deliver_later
      else
        RepaymentCalendarMailer.repayment_calendar_update_with_validation_link(context.repayment_calendar.id, admin_and_manager).deliver_later
      end
    end

    ims.each do |im|
      next if im == user

      RepaymentCalendarMailer.repayment_calendar_update_without_validation_link(context.repayment_calendar.id, im).deliver_later
    end
  end

  def merged_repayment_attributes
    attributes_h = {}
    principal_lines_attributes = params['principal_repayment_lines_attributes'].try(:values) || []
    interest_lines_attributes = params['interest_repayment_lines_attributes'].try(:values) || []
    (principal_lines_attributes | interest_lines_attributes).each_with_index do |attributes, index|
      attributes_h[index] = attributes
    end

    {
      'repayment_calendar_lines_attributes' => attributes_h
    }
  end

  def filtered_merged_repayment_attributes
    repayments = merged_repayment_attributes['repayment_calendar_lines_attributes'].values
    repayments_attributes = {}
    repayments.each_with_index do |repayment, index|
      repayments_attributes[index] = {
        'repayment_date' => repayment['repayment_date'].is_a?(Date) ? repayment['repayment_date'] : Date.parse(repayment['repayment_date']),
        'original_amount' => repayment['original_amount'],
        'received_amount' => repayment['received_amount'],
        'status' => repayment['status'],
        'repayment_type' => repayment['repayment_type'],
        'provision' => repayment['provision'],
        'previous_version_line_id' => repayment['id']
      }
    end

    {
      creation_user: user,
      repayment_calendar_lines_attributes: repayments_attributes
    }.merge(versioning_params)
  end

  def repayment_line_attributes
    %i[repayment_date repayment_type original_amount received_amount status provision]
  end

  def versioning_params
    if user.administrator? || user.general_manager?
      { version_status: LoanVersion::VERSION_STATUS_VALIDATED, validation_user: user }
    else
      { version_status: LoanVersion::VERSION_STATUS_TEMPORARY, validation_user: nil }
    end
  end

  def update_maturity_date
    sorted_repayment_calendar_line = new_repayment_calendar.get_sorted_repayment_calendar_lines_by_repayment_date_asc
    last_pending_repayment_calendar = new_repayment_calendar.get_last_pending_repayment_calendar_line

    if(last_pending_repayment_calendar.present?)
      new_loan_version.maturity_date = last_pending_repayment_calendar.repayment_date
    elsif(sorted_repayment_calendar_line.last.present?)
      new_loan_version.maturity_date = sorted_repayment_calendar_line.last.repayment_date
    end

    if(new_loan_version.invested? && new_loan_version.maturity_date_is_in_past?)
      new_loan_version.status = LoanVersion::STATUS_MATURED
      send_loan_version_status_update_notifications
    elsif(new_loan_version.matured? && new_loan_version.maturity_date_is_in_futur?)
      new_loan_version.status = LoanVersion::STATUS_INVESTED
      send_loan_version_status_update_notifications
    end

    new_loan_version.save!
  end

  def send_loan_version_status_update_notifications
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
end
