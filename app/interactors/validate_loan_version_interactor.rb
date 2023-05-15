# frozen_string_literal: true

class ValidateLoanVersionInteractor
  include Interactor
  def call
    Loan.transaction do
      change_loan_version_status
      change_repayment_calendar_status
      send_validation_email
    rescue StandardError => e
      Rails.logger.debug(e.backtrace.inspect)
      context.fail!(error_message: e.message)
    end
  end

  delegate :loan_version, :user, :validation_object, to: :context

  private

  def change_loan_version_status
    loan_version.update(version_status: LoanVersion::VERSION_STATUS_VALIDATED, validation_user: user) || context.fail!
  end

  def change_repayment_calendar_status
    calendar = loan_version.repayment_calendar
    return if calendar.blank?

    calendar.update(version_status: LoanVersion::VERSION_STATUS_VALIDATED, validation_user: user) || context.fail!
    calendar.calendar_log.lines.create!(
      action: CalendarLogLine::ACTION_VALIDATION,
      original_value: RepaymentCalendar::VERSION_STATUS_TEMPORARY,
      new_value: RepaymentCalendar::VERSION_STATUS_VALIDATED
    )
  end

  def send_validation_email
    if validation_object == 'version'
      LoanMailer.loan_version_validated(loan_version.id).deliver_later
    else
      RepaymentCalendarMailer.repayment_calendar_validated(loan_version.repayment_calendar.id).deliver_later
    end
  end
end
