# frozen_string_literal: true

FactoryBot.define do
  factory :institution_group do
    fund
    name { "#{FFaker::Lorem.word}_#{rand(1000)}" }
    created_by { FFaker::Name.name }
  end
end
