# frozen_string_literal: true

class InstitutionEsgPaiIndicatorDecorator < ApplicationDecorator
  delegate_all

  decorates InstitutionEsgPaiIndicator

  # tCO²e / million USD
  %i[ scope_1_emissions
      scope_2_emissions
      scope_3_emissions
      sum_ghg_scope_emissions
      carbon_footprint
      ghg_intensity_investee_companies
      emissions_to_water].each do |attr|
    define_method "#{attr.to_sym}_t_co_per_million_usd" do
      number_to_currency(object.send(attr), format: '%n tCO²e / million USD', precision: 7)
    end
  end

  # %
  %i[ exposure_companies_active_in_fossil_fuel_sector
      share_of_non_renewable_energy_consumption_and_production
      activities_negatively_affecting_biodiversity_sensitive_areas
      violations_of_un_global_compact_principles_and_oecd_guidelines_for_multinational_enterprises
      lack_of_processes_and_compliance_mechanisms_to_monitor_compliance_with_un_global_compact_principles
      unadjusted_gender_pay_gap
      board_gender_diversity
      exposure_to_controversial_weapons].each do |attr|
    define_method "#{attr.to_sym}_percent" do
      number_to_currency(object.send(attr), format: '%n %', precision: 7)
    end
  end

  # GWh/ million USD
  %i[energy_consumption_intensity_per_high_impact_climate_sector].each do |attr|
    define_method "#{attr.to_sym}_gwh_per_million_usd" do
      number_to_currency(object.send(attr), format: '%n GWh/ million USD', precision: 7)
    end
  end

  # t/million USD
  %i[hazardous_waste_ratio].each do |attr|
    define_method "#{attr.to_sym}_t_per_million_usd" do
      number_to_currency(object.send(attr), format: '%n t/million USD', precision: 7)
    end
  end
end
