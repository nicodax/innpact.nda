# frozen_string_literal: true

FactoryBot.define do
  factory :interest_rate_type do
    fund
    name { "#{FFaker::Lorem.word}_#{rand(1000)}" }
    description { FFaker::Lorem.words(num = 3) }
  end
end
