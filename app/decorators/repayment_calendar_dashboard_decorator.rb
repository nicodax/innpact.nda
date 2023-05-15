class RepaymentCalendarDashboardDecorator < ApplicationDecorator
  decorates Loan

  def active_repayment_calendar
    @active_repayment_calendar ||= object.active_repayment_calendar.decorate
  end

  def first_repayment_calendar
    @first_repayment_calendar ||= object.first_repayment_calendar.decorate
  end

  def logs
    @logs ||= CalendarLogDecorator.decorate_collection(object.calendar_logs.order(created_at: :desc))
  end

  def loan_provisions
    @loan_provisions = LoanProvisionDecorator.decorate_collection(object.loan_provisions.order(created_at: :desc))
  end
end
