# frozen_string_literal: true

FactoryBot.define do
  factory :im_group do
    sequence(:name) { |t| "#{FFaker::Lorem.word}#{t}" }
    description { FFaker::Lorem.sentence }
    fund
  end
end
