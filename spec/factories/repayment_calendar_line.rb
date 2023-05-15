# frozen_string_literal: true

FactoryBot.define do
  factory :repayment_calendar_line do
    repayment_date { Date.today + 1.month }
    repayment_type { RepaymentCalendarLine::REPAYMENT_TYPE_PRINCIPAL }
    original_amount { 50.3 }
    status { RepaymentCalendarLine::STATUS_PENDING }
  end
end
