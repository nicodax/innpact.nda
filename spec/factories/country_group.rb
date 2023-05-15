# frozen_string_literal: true

FactoryBot.define do
  factory :country_group do
    fund
    name { "#{FFaker::Lorem.word}_#{rand(1000)}" }
    countries { [association(:country, fund: fund)] }
  end
end
