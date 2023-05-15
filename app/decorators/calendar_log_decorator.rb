class CalendarLogDecorator < ApplicationDecorator
  decorates CalendarLog

  def lines
    CalendarLogLineDecorator.decorate_collection(object.lines).group_by { |l|
      l.new_repayment_line_id || 0
    }.map do |_, l|
      {
        original_repayment_line: l.first.original_repayment_line.try(:decorate),
        new_repayment_line: l.first.new_repayment_line.try(:decorate),
        changed_attributes: l.map(&:changed_attribute),
        action: l.first.action,
        repayment_type: l.first.new_repayment_line.try(:repayment_type)
      }
    end
  end

  def user_name
    creation_user.full_name
  end

  def creation_date
    created_at.strftime("%d/%m/%Y %H:%M")
  end

  def status_label_class
    {
      RepaymentCalendar::VERSION_STATUS_VALIDATED => "",
      RepaymentCalendar::VERSION_STATUS_TEMPORARY => "warning",
      RepaymentCalendar::VERSION_STATUS_REJECTED => "alert",
    }[repayment_calendar.version_status]
  end

  def validation_message
    I18n.t("repayment_calendars.version_#{repayment_calendar.version_status}",
           user_name: (repayment_calendar.rejection_user || repayment_calendar.validation_user).full_name)
  end
end
