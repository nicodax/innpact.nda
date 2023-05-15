# frozen_string_literal: true

class ValidateInstitutionProvisionInteractor
  include Interactor

  delegate :institution_provision, :validated, :user, to: :context

  def call
    InstitutionProvision.transaction do
      validate_provision
      assign_provision_to_invested_loans
      send_notification
    rescue StandardError => e
      context.fail!(error_message: e.message)
    end
  end

  private

  def validate_provision
    attrs = if ActiveModel::Type::Boolean.new.cast(validated)
              { version_status: InstitutionProvision::VERSION_STATUS_VALIDATED }
            else
              {
                version_status: InstitutionProvision::VERSION_STATUS_REJECTED,
                new_percentage_of_provision: institution_provision.previous_percentage_of_provision,
                percentage: institution_provision.previous_percentage_of_provision
              }
            end

    if institution_provision.temporary? && institution_provision.update(attrs)
      context.institution_provision = institution_provision
    else
      context.fail!
    end
  end

  def assign_provision_to_invested_loans
    return if institution_provision.version_status != InstitutionProvision::VERSION_STATUS_VALIDATED

    institution_provision.institution.loans.invested.each do |loan|
      repayment_lines_to_provision = RepaymentCalendarLine.for_loan(loan).pending_status.principal

      unless repayment_lines_to_provision.load.empty?
        update_loan_provision(loan: loan, repayment_lines_to_provision: repayment_lines_to_provision)
      end
    end
  end

  def update_loan_provision(loan:, repayment_lines_to_provision: [])
    previous_amount_of_provision = loan.provision_amount
    new_amount_of_provision = loan.gross_position_value * institution_provision.percentage

    loan_version = loan.build_new_version_with_calendar(loan_version_params.merge({ provision_date: Date.today }),
                                                        loan_version_params)

    new_calendar = loan_version.repayment_calendar
    new_calendar.save!

    LoanProvision.create!(
      percentage: institution_provision.percentage,
      amount: new_amount_of_provision,
      previous_amount_of_provision: previous_amount_of_provision,
      new_amount_of_provision: new_amount_of_provision,
      loan: loan,
      institution_provision: institution_provision,
      creation_user: user,
      repayment_calendar: new_calendar
    )

    calendar_log = CalendarLog.create!(
      repayment_calendar: new_calendar,
      creation_user: user
    )

    repayment_lines_to_provision.each do |repayment_line|
      provision_to_add = repayment_line.original_amount * institution_provision.percentage
      old_provision = repayment_line.provision
      new_provision = provision_to_add

      new_line = new_calendar.repayment_calendar_lines.detect { |line|
        line.previous_version_line_id == repayment_line.id
      }
      new_line.provision = new_provision

      CalendarLogLine.create!(
        calendar_log: calendar_log,
        action: CalendarLogLine::ACTION_INSTITUTION_PROVISION,
        original_repayment_line: repayment_line,
        changed_attribute: 'provision',
        original_value: old_provision,
        new_value: new_provision,
        new_repayment_line: new_line
      )
    end

    gross_position_value = new_calendar.temp_gross_amount
    loan_version.gross_position_value = gross_position_value
    provision_value = new_calendar.temp_provision_amount
    loan_version.provision_value = provision_value
    loan_version.net_position_value = gross_position_value - provision_value

    new_calendar.save!
    loan_version.save!
    loan.save!
  end

  def send_notification
    InstitutionMailer.institution_provision_validation(institution_provision).deliver_later
  end

  def loan_version_params
    { version_status: LoanVersion::VERSION_STATUS_VALIDATED, validation_user: user }
  end
end
