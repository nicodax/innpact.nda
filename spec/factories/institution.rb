# frozen_string_literal: true

FactoryBot.define do
  factory :institution do
    association :fund
    sequence(:name) { |n| "#{FFaker::Lorem.word}_#{n}" }
    institution_type { association :institution_type, fund: fund }
    institution_group { association :institution_group, fund: fund }
    country { association :country, fund: fund }
    im_group { association :im_group, fund: fund }
  end
end
