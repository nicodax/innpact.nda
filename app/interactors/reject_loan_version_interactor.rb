# frozen_string_literal: true

class RejectLoanVersionInteractor
  include Interactor
  def call
    Loan.transaction do
      change_loan_version_status
      change_repayment_calendar_status
      create_new_loan_version
      send_rejection_email
    rescue StandardError => e
      Rails.logger.debug(e.backtrace.inspect)
      context.fail!(error_message: e.message)
    end
  end

  delegate :loan_version, :user, :validation_object, to: :context

  private

  def change_loan_version_status
    loan_version.loan.loan_sdg_data.latest(loan_version.loan.id).first&.delete
    loan_version.loan.presentation_compliance_checks.latest(loan_version.loan_id).first&.delete
    loan_version.update(version_status: LoanVersion::VERSION_STATUS_REJECTED, rejection_user: user) || context.fail!
  end

  def change_repayment_calendar_status
    calendar = loan_version.repayment_calendar
    return if calendar.blank?

    calendar.update(version_status: LoanVersion::VERSION_STATUS_REJECTED, rejection_user: user) || context.fail!
    calendar.calendar_log.lines.create!(
      action: CalendarLogLine::ACTION_REJECTION,
      original_value: RepaymentCalendar::VERSION_STATUS_TEMPORARY,
      new_value: RepaymentCalendar::VERSION_STATUS_REJECTED
    )
  end

  def create_new_loan_version
    loan_version.loan.build_new_version_from_last_validated(version_params, version_params)
    loan_version.loan.save || context.fail!
  end

  def send_rejection_email
    if validation_object == 'version'
      LoanMailer.loan_version_rejected(loan_version.id).deliver_later
    else
      RepaymentCalendarMailer.repayment_calendar_rejected(loan_version.repayment_calendar.id).deliver_later
    end
  end

  def version_params
    { creation_user: user, validation_user: user }
  end
end
