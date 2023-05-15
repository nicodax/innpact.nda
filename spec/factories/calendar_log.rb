# frozen_string_literal: true

FactoryBot.define do
  factory :calendar_log do
    repayment_calendar
    creation_user { association(:user) }
  end
end
