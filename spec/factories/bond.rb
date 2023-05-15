# frozen_string_literal: true

FactoryBot.define do
  factory :bond do
    name { "#{FFaker::Lorem.word}_#{rand(1000)}" }
    description { FFaker::Lorem.word }
    fund
  end
end
