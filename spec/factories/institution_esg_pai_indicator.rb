# frozen_string_literal: true

FactoryBot.define do
  factory :institution_esg_pai_indicator do
    institution { association :institution }
    user_id { FactoryBot.create(:user).id }
    as_of { DateTime.now }
    scope_1_emissions { rand(100) }
    scope_2_emissions { rand(100) }
    scope_3_emissions { rand(100) }
    carbon_footprint { rand(100) }
    ghg_intensity_investee_companies { rand(100) }
    exposure_companies_active_in_fossil_fuel_sector { rand(100) }
    share_of_non_renewable_energy_consumption_and_production { rand(100) }
    energy_consumption_intensity_per_high_impact_climate_sector { rand(100) }
    activities_negatively_affecting_biodiversity_sensitive_areas { rand(100) }
    emissions_to_water { rand(100) }
    hazardous_waste_ratio { rand(100) }
    violations_of_un_global_compact_principles_and_oecd_guidelines_for_multinational_enterprises { rand(100) }
    lack_of_processes_and_compliance_mechanisms_to_monitor_compliance_with_un_global_compact_principles { rand(100) }
    unadjusted_gender_pay_gap { rand(100) }
    board_gender_diversity { rand(100) }
    exposure_to_controversial_weapons { rand(100) }
  end
end
