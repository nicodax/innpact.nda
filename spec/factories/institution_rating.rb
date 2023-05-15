# frozen_string_literal: true

FactoryBot.define do
  factory :institution_rating do
    institution { association :institution }
    user_id { FactoryBot.create(:user).id }
    as_of { DateTime.now }
    external_rating { FFaker::Lorem.sentence[0..9] }
    external_rating_agency { FFaker::Lorem.sentence[0..9] }
    internal_credit_risk_rating { FFaker::Lorem.sentence[0..9] }
    probability_of_default { rand(1000) / 10 }
  end
end
