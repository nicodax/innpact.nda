# frozen_string_literal: true

class ValidateRepaymentCalendarInteractor
  include Interactor
  def call
    RepaymentCalendar.transaction do
      begin
        change_repayment_calendar_status
        create_new_log_line
        send_validation_email
      rescue StandardError => e
        context.fail!
      end
    end
  end

  delegate :repayment_calendar, :user, to: :context

  private

  def change_repayment_calendar_status
    repayment_calendar.update!(version_status: LoanVersion::VERSION_STATUS_VALIDATED, validation_user: user)
  end

  def create_new_log_line
    repayment_calendar.calendar_log.lines.create!(
      action: CalendarLogLine::ACTION_VALIDATION,
      original_value: RepaymentCalendar::VERSION_STATUS_TEMPORARY,
      new_value: RepaymentCalendar::VERSION_STATUS_VALIDATED,
    )
  end

  def send_validation_email
    RepaymentCalendarMailer.repayment_calendar_validated(repayment_calendar.id).deliver_later
  end
end
