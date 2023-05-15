# frozen_string_literal: true

FactoryBot.define do
  factory :additional_pais_environment do
    institution { association :institution }
    user_id { FactoryBot.create(:user).id }
    as_of { DateTime.now }
    environment_pai_reported { "E#{rand(10)}" }
    environment_pai_value { rand(1_000_000) / 1000 }
  end
end
