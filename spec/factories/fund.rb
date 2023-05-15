# frozen_string_literal: true

FactoryBot.define do
  factory :fund do
    name { FFaker::Lorem.word }
    created_by { FFaker::Name.name }
    status { 'active' }
  end
end
