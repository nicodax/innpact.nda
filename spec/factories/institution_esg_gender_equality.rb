# frozen_string_literal: true

FactoryBot.define do
  factory :institution_esg_gender_equality do
    institution { association :institution }
    user_id { FactoryBot.create(:user).id }
    as_of { DateTime.now }
    financial_services_targeting_women { [true, false].sample }
    non_financial_services_targeting_women { [true, false].sample }
    women_percentage_in_board { rand(100) }
    women_percentage_in_staff { rand(100) }
    training_on_responsible_finance_targeting_women { [true, false].sample }
    women_percentage_in_management { rand(100) }
  end
end
