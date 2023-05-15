# frozen_string_literal: true

FactoryBot.define do
  factory :repayment_calendar do
      loan_version
      creation_user { association :user }
      repayment_calendar_lines { build_list(:repayment_calendar_line, 2) }
  end
end
