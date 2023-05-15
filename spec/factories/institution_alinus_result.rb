# frozen_string_literal: true

FactoryBot.define do
  factory :institution_alinus_result do
    institution { association :institution }
    user_id { FactoryBot.create(:user).id }
    as_of { DateTime.now }
    overall_sptf_alinus_score { rand(10_000) / 100 }
    define_and_monitor_social_goals { rand(10_000) / 100 }
    ensure_commitment_to_social_goals { rand(10_000) / 100 }
    product_design_to_meet_clients_need { rand(10_000) / 100 }
    treat_clients_responsibly { rand(10_000) / 100 }
    treat_employees_responsibly { rand(10_000) / 100 }
    balance_financial_and_performance { rand(10_000) / 100 }
    promote_environmental_protection { rand(10_000) / 100 }
  end
end
