# frozen_string_literal: true

FactoryBot.define do
  factory :repayment_type do
    fund
    name { "#{FFaker::Lorem.word}_#{rand(1000)}" }
    description { FFaker::Lorem.word }
  end
end
