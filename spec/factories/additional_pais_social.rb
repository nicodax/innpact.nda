# frozen_string_literal: true

FactoryBot.define do
  factory :additional_pais_social do
    institution { association :institution }
    user_id { FactoryBot.create(:user).id }
    as_of { DateTime.now }
    social_pai_reported { "E#{rand(10)}" }
    social_pai_value { rand(1_000_000) / 1000 }
  end
end
