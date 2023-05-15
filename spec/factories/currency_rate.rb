# frozen_string_literal: true

FactoryBot.define do
  factory :currency_rate do
    currency
    rate { rand(3) / 10 }
    created_by { FFaker::Lorem.word }
  end
end
