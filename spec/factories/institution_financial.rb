# frozen_string_literal: true

FactoryBot.define do
  factory :institution_financial do
    institution { association :institution }
    user_id { FactoryBot.create(:user).id }
    as_of { DateTime.now }
    liabilities { rand(1_000_000) / 100 }
    domestic_liabilities { rand(1_000_000) / 100 }
    international_liabilities { rand(1_000_000) / 100 }
    revenues { rand(1_000_000) / 100 }
    net_income_distributed_as_dividends { rand(1_000_000) / 100 }
    provision_for_loss { rand(1_000_000) / 100 }
    write_off { rand(1_000_000) / 100 }
    deposit_amount { rand(1_000_000) / 100 }
    total_assets { rand(1_000_000) / 100 }
    gross_loan_portfolio { rand(1_000_000) / 100 }
    equity { rand(1_000_000) / 100 }
    net_income { rand(1_000_000) / 100 }
    npls { rand(1_000_000) / 100 }
  end
end
