# frozen_string_literal: true

FactoryBot.define do
  factory :institution_esg_sdg_contribution do
    institution { association :institution }
    user_id { FactoryBot.create(:user).id }
    as_of { DateTime.now }
    no_poverty { [true, false].sample }
    zero_hunger { [true, false].sample }
    good_health_and_wellbeing { [true, false].sample }
    quality_education { [true, false].sample }
    gender_equality { [true, false].sample }
    clean_water_and_sanitation { [true, false].sample }
    affordable_and_clean_energy { [true, false].sample }
    descent_work_and_economic_growth { [true, false].sample }
    industry_innovation_and_infrastructure { [true, false].sample }
    reduced_inequalities { [true, false].sample }
    sustainable_cities_and_communities { [true, false].sample }
    responsible_consumption_and_production { [true, false].sample }
    climate_action { [true, false].sample }
    life_below_water { [true, false].sample }
    life_on_land { [true, false].sample }
    peace_justice_and_strong_institutions { [true, false].sample }
    partnerships_for_the_goals { [true, false].sample }
  end
end
