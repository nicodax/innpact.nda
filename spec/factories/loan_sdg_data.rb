# frozen_string_literal: true

FactoryBot.define do
  factory :loan_sdg_data do
    loan
    no_poverty { FFaker::Boolean.maybe }
    zero_hunger { FFaker::Boolean.maybe }
    good_health_and_wellbeing { FFaker::Boolean.maybe }
    quality_education { FFaker::Boolean.maybe }
    gender_equality { FFaker::Boolean.maybe }
    clean_water_and_sanitation { FFaker::Boolean.maybe }
    affordable_and_clean_energy { FFaker::Boolean.maybe }
    descent_work_and_economic_growth { FFaker::Boolean.maybe }
    industry_innovation_and_infrastructure { FFaker::Boolean.maybe }
    reduced_inequalities { FFaker::Boolean.maybe }
    sustainable_cities_and_conmmunities { FFaker::Boolean.maybe }
    responsible_consumption_and_production { FFaker::Boolean.maybe }
    climate_action { FFaker::Boolean.maybe }
    life_below_water { FFaker::Boolean.maybe }
    life_on_land { FFaker::Boolean.maybe }
    peace_justice_and_strong_institutions { FFaker::Boolean.maybe }
    partnerships_for_the_goals { FFaker::Boolean.maybe }
  end
end
