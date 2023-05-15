# frozen_string_literal: true

FactoryBot.define do
  factory :country do
    name { "#{FFaker::Lorem.word}_#{rand(1000)}" }
    iso_code { "#{FFaker::Lorem.word}_##{rand(1000)}" }
    created_by { FFaker::Name.name }
    fund
  end
end
