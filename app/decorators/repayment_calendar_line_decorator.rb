include ActionView::Helpers::NumberHelper

class RepaymentCalendarLineDecorator < ApplicationDecorator
  decorates RepaymentCalendarLine

  [:original_amount, :received_amount, :provision].each do |attr|
    define_method "#{attr}_currency_value" do
      number_to_currency(object.send(attr), unit: currency_unit, format: "%n %u")
    end

    define_method "#{attr}_usd_value" do
      number_to_currency(object.send(attr) / currency_rate, unit: "$", format: "%n %u")
    end
  end

  def loan
    repayment_calendar.loan
  end

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

  def formatted_repayment_type
    icon = repayment_type == RepaymentCalendarLine::REPAYMENT_TYPE_PRINCIPAL ? "fi-page" : "fi-page-multiple"
    ("<i class='#{icon}'></i> \n " + I18n.t("activerecord.attributes.repayment_calendar_line.repayment_types.#{repayment_type}")).html_safe
  end

  def currency_unit
    loan.currency.short_name
  end

  def currency_rate
    loan.currency.current_rate
  end
end
