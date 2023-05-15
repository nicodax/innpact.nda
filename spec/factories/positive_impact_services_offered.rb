# frozen_string_literal: true

FactoryBot.define do
  factory :positive_impact_services_offered do
    institution { association :institution }
    user_id { FactoryBot.create(:user).id }
    as_of { DateTime.now }
    mobile_banking_services { [true, false].sample }
    number_clients_using_mobile_banking { rand(1_000_000) }
    deposits { [true, false].sample }
    number_clients_with_deposits { rand(1_000_000) }
    voluntary_savings { [true, false].sample }
  end
end
