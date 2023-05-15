class CalendarLogLineDecorator < ApplicationDecorator
  decorates CalendarLogLine

  def formatted_date
    repayment_date.strftime("%d/%m/%Y")
  end

  def formatted_status
    icon = {
      RepaymentCalendarLine::STATUS_UNPAID => "fi-x",
      RepaymentCalendarLine::STATUS_PAID => "fi-check",
      RepaymentCalendarLine::STATUS_PENDING => "fi-calendar"
    }[status]
    ("<i class='#{icon}'></i> \n " + I18n.t("activerecord.attributes.repayment_calendar_line.statuses.#{status}")).html_safe
  end
end
