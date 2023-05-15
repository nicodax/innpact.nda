# frozen_string_literal: true

FactoryBot.define do
  factory :institution_type do
    fund
    name { "#{FFaker::Lorem.word}_#{rand(1000)}" }
    description { "#{FFaker::Lorem.word}_#{rand(1000)}" }
  end
end
