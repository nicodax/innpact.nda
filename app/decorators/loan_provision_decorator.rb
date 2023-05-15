include ActionView::Helpers::NumberHelper

class LoanProvisionDecorator < ApplicationDecorator
  def formatted_previous_amount_of_provision
    number_to_currency(previous_amount_of_provision, unit: repayment_calendar.loan_version.currency.short_name,
                                                     format: "%n %u")
  end

  def formatted_new_amount_of_provision
    number_to_currency(new_amount_of_provision, unit: repayment_calendar.loan_version.currency.short_name,
                                                format: "%n %u")
  end

  def creation_user_name
    creation_user.full_name
  end

  def comment
    institution_provision.try(:comment)
  end

  def version_status
    repayment_calendar.version_status
  end

  def version_status_label_class
    {
      RepaymentCalendar::VERSION_STATUS_VALIDATED => "",
      RepaymentCalendar::VERSION_STATUS_TEMPORARY => "warning",
      RepaymentCalendar::VERSION_STATUS_REJECTED => "alert",
    }[repayment_calendar.version_status]
  end
end
