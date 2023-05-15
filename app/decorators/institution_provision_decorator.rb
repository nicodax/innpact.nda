include ActionView::Helpers::NumberHelper

class InstitutionProvisionDecorator < ApplicationDecorator
  def formatted_percentage
    number_to_percentage(percentage * 100, precision: 2)
  end

  def formatted_previous_percentage_of_provision
    number_to_percentage(previous_percentage_of_provision * 100, precision: 2)
  end

  def formatted_new_percentage_of_provision
    number_to_percentage(new_percentage_of_provision * 100, precision: 2)
  end

  def creation_user_name
    creation_user.full_name
  end

  def version_status_label_class
    {
      RepaymentCalendar::VERSION_STATUS_VALIDATED => "",
      RepaymentCalendar::VERSION_STATUS_TEMPORARY => "warning",
      RepaymentCalendar::VERSION_STATUS_REJECTED => "alert",
    }[repayment_calendar.version_status]
  end
end
