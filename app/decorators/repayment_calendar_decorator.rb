class RepaymentCalendarDecorator < ApplicationDecorator
  decorates RepaymentCalendar

  def principals
    RepaymentCalendarLineDecorator.decorate_collection(principal_repayment_lines)
  end

  def interests
    RepaymentCalendarLineDecorator.decorate_collection(interest_repayment_lines)
  end
end
