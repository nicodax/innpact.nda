# frozen_string_literal: true

FactoryBot.define do
  factory :pool do
    association :fund, factory: :fund
    name { "#{FFaker::Lorem.word}_#{rand(1000)}" }
    subscription_date { Date.today - 1.month }
    maturity_date { Date.today + 1.month }
    amount { rand(10_000) + 1 }
    amount_in_usd { rand(10_000) + 1 }
    trait :targeted do
      is_targeted { true }
      loan_types { [association(:loan_type, fund: fund)] }
    end
    trait :global do
      is_targeted { false }
    end
    currency { association :currency, fund: fund }
  end
end
