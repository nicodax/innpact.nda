# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    sequence(:email) { FFaker::Internet.email }
    firstname { FFaker::Name.first_name }
    lastname { FFaker::Name.last_name }
    password { 'topsecret' }

    factory :administrator do
      after(:create) { |user| user.add_role(:administrator) }
    end

    factory :general_manager do
      after(:create) { |user| user.add_role(:general_manager) }
    end

    factory :investment_manager do
      after(:create) { |user| user.add_role(:investment_manager) }
    end

    factory :reader do
      after(:create) { |user| user.add_role(:reader) }
    end

    factory :system do
      after(:create) { |user| user.add_role(:system) }
    end
  end
end
