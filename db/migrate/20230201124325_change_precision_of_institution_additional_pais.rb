class ChangePrecisionOfInstitutionAdditionalPais < ActiveRecord::Migration[6.0]
  def up
    change_column :additional_pais_environments, :environment_pai_value, :decimal, precision: 23, scale: 7
    change_column :additional_pais_socials, :social_pai_value, :decimal, precision: 23, scale: 7
    change_column :institution_esg_pai_indicators, :scope_1_emissions, :decimal, precision: 23, scale: 7
    change_column :institution_esg_pai_indicators, :scope_2_emissions, :decimal, precision: 23, scale: 7
    change_column :institution_esg_pai_indicators, :scope_3_emissions, :decimal, precision: 23, scale: 7
    change_column :institution_esg_pai_indicators, :carbon_footprint, :decimal, precision: 23, scale: 7
    change_column :institution_esg_pai_indicators, :ghg_intensity_investee_companies, :decimal, precision: 23, scale: 7
    change_column :institution_esg_pai_indicators, :exposure_companies_active_in_fossil_fuel_sector, :decimal, precision: 10, scale: 7
    change_column :institution_esg_pai_indicators, :share_of_non_renewable_energy_consumption_and_production, :decimal, precision: 10, scale: 7
    change_column :institution_esg_pai_indicators, :energy_consumption_intensity_per_high_impact_climate_sector, :decimal, precision: 23, scale: 7
    change_column :institution_esg_pai_indicators, :activities_negatively_affecting_biodiversity_sensitive_areas, :decimal, precision: 10, scale: 7
    change_column :institution_esg_pai_indicators, :emissions_to_water, :decimal, precision: 23, scale: 7
    change_column :institution_esg_pai_indicators, :hazardous_waste_ratio, :decimal, precision: 23, scale: 7
    change_column :institution_esg_pai_indicators, :violations_of_un_global_compact_principles_and_oecd_guidelines_for_multinational_enterprises, :decimal, precision: 10, scale: 7
    change_column :institution_esg_pai_indicators, :lack_of_processes_and_compliance_mechanisms_to_monitor_compliance_with_un_global_compact_principles, :decimal, precision: 10, scale: 7
    change_column :institution_esg_pai_indicators, :unadjusted_gender_pay_gap, :decimal, precision: 10, scale: 7
    change_column :institution_esg_pai_indicators, :board_gender_diversity, :decimal, precision: 10, scale: 7
    change_column :institution_esg_pai_indicators, :exposure_to_controversial_weapons, :decimal, precision: 10, scale: 7
  end
  def down
    change_column :additional_pais_environments, :environment_pai_value, :decimal, precision: 18, scale: 2
    change_column :additional_pais_socials, :social_pai_value, :decimal, precision: 18, scale: 2
    change_column :institution_esg_pai_indicators, :scope_1_emissions, :decimal, precision: 18, scale: 2
    change_column :institution_esg_pai_indicators, :scope_2_emissions, :decimal, precision: 18, scale: 2
    change_column :institution_esg_pai_indicators, :scope_3_emissions, :decimal, precision: 18, scale: 2
    change_column :institution_esg_pai_indicators, :carbon_footprint, :decimal, precision: 18, scale: 2
    change_column :institution_esg_pai_indicators, :ghg_intensity_investee_companies, :decimal, precision: 18, scale: 2
    change_column :institution_esg_pai_indicators, :exposure_companies_active_in_fossil_fuel_sector, :decimal, precision: 5, scale: 2
    change_column :institution_esg_pai_indicators, :share_of_non_renewable_energy_consumption_and_production, :decimal, precision: 5, scale: 2
    change_column :institution_esg_pai_indicators, :energy_consumption_intensity_per_high_impact_climate_sector, :decimal, precision: 18, scale: 2
    change_column :institution_esg_pai_indicators, :activities_negatively_affecting_biodiversity_sensitive_areas, :decimal, precision: 5, scale: 2
    change_column :institution_esg_pai_indicators, :emissions_to_water, :decimal, precision: 18, scale: 2
    change_column :institution_esg_pai_indicators, :hazardous_waste_ratio, :decimal, precision: 18, scale: 2
    change_column :institution_esg_pai_indicators, :violations_of_un_global_compact_principles_and_oecd_guidelines_for_multinational_enterprises, :decimal, precision: 5, scale: 2
    change_column :institution_esg_pai_indicators, :lack_of_processes_and_compliance_mechanisms_to_monitor_compliance_with_un_global_compact_principles, :decimal, precision: 5, scale: 2
    change_column :institution_esg_pai_indicators, :unadjusted_gender_pay_gap, :decimal, precision: 5, scale: 2
    change_column :institution_esg_pai_indicators, :board_gender_diversity, :decimal, precision: 5, scale: 2
    change_column :institution_esg_pai_indicators, :exposure_to_controversial_weapons, :decimal, precision: 5, scale: 2
  end
end
