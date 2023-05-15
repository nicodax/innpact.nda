# frozen_string_literal: true

FactoryBot.define do
  factory :institution_specific_breakdown do
    institution { association :institution }
    user_id { FactoryBot.create(:user).id }
    as_of { DateTime.now }
    microfinance_portfolio_size { rand(1_000_000) / 100 }
    sme_portfolio_size_under_35k { rand(1_000_000) / 100 }
    sme_portfolio_size_under_50k { rand(1_000_000) / 100 }
    percentage_loans_to_rural_borrowers_per_glp { rand(1_000) / 100 }
    production { 20 }
    agriculture { 20 }
    consumption { 20 }
    by_sector_other { 20 }
    trade_and_services { 20 }
    microenterprise { 20 }
    sme { 20 }
    corporate { 20 }
    housing { 20 }
    personal { 20 }
    by_loan_purpose_other { 0 }
  end
end
