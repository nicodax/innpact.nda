# frozen_string_literal: true

FactoryBot.define do
  factory :loan_type do
    fund
    name { "#{FFaker::Lorem.word}_#{rand(1000)}" }
  end
end
