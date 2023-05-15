# frozen_string_literal: true

FactoryBot.define do
  factory :institution_covenant do
    sequence(:name) { |n| "#{FFaker::Lorem.word}_#{n}" }
    institution
    fund_id do
      institution&.fund&.id
    end
  end
end
