# frozen_string_literal: true

FactoryBot.define do
  factory :institution_impact_indicator do
    institution { association :institution }
    user_id { FactoryBot.create(:user).id }
    as_of { DateTime.now }
    borrowers_count { rand(1_000_000) / 100 }
    female_borrowers_count { rand(1_000_000) / 100 }
    rural_borrowers_count { rand(1_000_000) / 100 }
    number_of_micro_borrowers { rand(1_000_000) / 100 }
    number_of_sme_borrowers { rand(1_000_000) / 100 }
    avg_loan_size { rand(1_000_000) / 100 }
    internal_impact_score { FFaker::Lorem.sentence[0..9] }
    number_of_clients { rand(100_000) }
  end
end
