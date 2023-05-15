# frozen_string_literal: true

FactoryBot.define do
  factory :currency do
    name { "#{FFaker::Lorem.word}_#{rand(1000)}" }
    short_name { SecureRandom.hex(10).first(3) }
    fund
  end
end
