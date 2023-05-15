# frozen_string_literal: true

class RejectRepaymentCalendarInteractor
  include Interactor
  def call
    RepaymentCalendar.transaction do
      begin
        change_repayment_calendar_status
        create_new_log_line
        rebuild_last_loan_version
        send_rejection_email
      rescue StandardError => e
        context.fail!
      end
    end
  end

  delegate :repayment_calendar, :user, to: :context

  private

  def change_repayment_calendar_status
    repayment_calendar.update!(version_status: RepaymentCalendar::VERSION_STATUS_REJECTED, rejection_user: user)
  end

  def create_new_log_line
    repayment_calendar.calendar_log.lines.create!(
      action: CalendarLogLine::ACTION_REJECTION,
      original_value: RepaymentCalendar::VERSION_STATUS_TEMPORARY,
      new_value: RepaymentCalendar::VERSION_STATUS_REJECTED,
    )
  end

  def rebuild_last_loan_version
    repayment_calendar.loan.build_new_version_from_last_validated(version_params, version_params)
    repayment_calendar.loan.save!
  end

  def send_rejection_email
    RepaymentCalendarMailer.repayment_calendar_rejected(repayment_calendar.id).deliver_later
  end

  def version_params
    { creation_user: user, validation_user: user }
  end
end
