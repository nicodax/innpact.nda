# frozen_string_literal: true

FactoryBot.define do
  factory :institution_esg_risk do
    institution { association :institution }
    user_id { FactoryBot.create(:user).id }
    as_of { DateTime.now }
    internal_esg_score { FFaker::Lorem.word[0, 9] }
    ifc_esg_risk_financial_intermediaries_classification { %w[FI-3 FI-2 FI-1].sample }
    esms_in_place_commensurate_with_risk_profile { [true, false].sample }
  end
end
