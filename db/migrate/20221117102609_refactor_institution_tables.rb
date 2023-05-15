# frozen_string_literal: true

class RefactorInstitutionTables < ActiveRecord::Migration[6.0]
  def up
    change_column :institution_profiles, :use_of_standard_reporting_tools, :string

    change_column :institution_financials, :net_income_distributed_as_dividends, :decimal, precision: 18, scale: 2
    change_column :institution_financials, :npls, :decimal, precision: 18, scale: 2
    change_column :institution_financials, :write_off, :decimal, precision: 18, scale: 2

    rename_column :institution_specific_breakdowns, :percentage_rural_ptf, :percentage_loans_to_rural_borrowers_per_glp
    remove_column :institution_specific_breakdowns, :percentage_of_women_ptf, :decimal

    change_column :institution_distribution_by_sectors, :production, :decimal, precision: 5, scale: 2
    change_column :institution_distribution_by_sectors, :agriculture, :decimal, precision: 5, scale: 2
    change_column :institution_distribution_by_sectors, :consumption, :decimal, precision: 5, scale: 2
    change_column :institution_distribution_by_sectors, :other, :decimal, precision: 5, scale: 2
    change_column :institution_distribution_by_sectors, :trade_and_services, :decimal, precision: 5, scale: 2

    change_column :institution_distribution_by_loan_purposes, :microenterprise_usd, :decimal, precision: 5, scale: 2
    change_column :institution_distribution_by_loan_purposes, :sme_usd, :decimal, precision: 5, scale: 2
    change_column :institution_distribution_by_loan_purposes, :corporate_usd, :decimal, precision: 5, scale: 2
    change_column :institution_distribution_by_loan_purposes, :housing_usd, :decimal, precision: 5, scale: 2
    change_column :institution_distribution_by_loan_purposes, :personal_usd, :decimal, precision: 5, scale: 2
    change_column :institution_distribution_by_loan_purposes, :other_usd, :decimal, precision: 5, scale: 2
    rename_column :institution_distribution_by_loan_purposes, :microenterprise_usd, :microenterprise
    rename_column :institution_distribution_by_loan_purposes, :sme_usd, :sme
    rename_column :institution_distribution_by_loan_purposes, :corporate_usd, :corporate
    rename_column :institution_distribution_by_loan_purposes, :housing_usd, :housing
    rename_column :institution_distribution_by_loan_purposes, :personal_usd, :personal
    rename_column :institution_distribution_by_loan_purposes, :other_usd, :other

    add_column :institution_esg_gender_equalities, :percentage_loans_to_women_borrowers_per_glp, :decimal, precision: 5, scale: 2
    add_column :institution_esg_gender_equalities, :percentage_women_among_loan_officers, :decimal, precision: 5, scale: 2

    add_column :institution_esg_risks, :tool_use_for_esg_score, :text

    remove_column :institution_esg_pai_indicators, :ghg_emissions, :string
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
    change_column :institution_esg_pai_indicators, :violations_of_un_global_compact_principles_and_oecd_guidelines_for_multinational_enterprises,
                  :decimal, precision: 5, scale: 2
    change_column :institution_esg_pai_indicators,
                  :lack_of_processes_and_compliance_mechanisms_to_monitor_compliance_with_un_global_compact_principles, :decimal, precision: 5, scale: 2
    change_column :institution_esg_pai_indicators, :unadjusted_gender_pay_gap, :decimal, precision: 5, scale: 2
    change_column :institution_esg_pai_indicators, :board_gender_diversity, :decimal, precision: 5, scale: 2
    change_column :institution_esg_pai_indicators, :exposure_to_controversial_weapons, :decimal, precision: 5, scale: 2
  end

  def down
    change_column :institution_profiles, :use_of_standard_reporting_tools, :boolean

    change_column :institution_financials, :net_income_distributed_as_dividends, :decimal, precision: 17, scale: 2
    change_column :institution_financials, :npls, :decimal, precision: 5, scale: 2
    change_column :institution_financials, :write_off, :decimal, precision: 5, scale: 2

    rename_column :institution_specific_breakdowns, :percentage_loans_to_rural_borrowers_per_glp, :percentage_rural_ptf
    add_column :institution_specific_breakdowns, :percentage_of_women_ptf, :decimal, precision: 18, scale: 2

    change_column :institution_distribution_by_sectors, :production, :decimal, precision: 17, scale: 2
    change_column :institution_distribution_by_sectors, :agriculture, :decimal, precision: 17, scale: 2
    change_column :institution_distribution_by_sectors, :consumption, :decimal, precision: 17, scale: 2
    change_column :institution_distribution_by_sectors, :other, :decimal, precision: 17, scale: 2
    change_column :institution_distribution_by_sectors, :trade_and_services, :decimal, precision: 17, scale: 2

    rename_column :institution_distribution_by_loan_purposes, :microenterprise, :microenterprise_usd
    rename_column :institution_distribution_by_loan_purposes, :sme, :sme_usd
    rename_column :institution_distribution_by_loan_purposes, :corporate, :corporate_usd
    rename_column :institution_distribution_by_loan_purposes, :housing, :housing_usd
    rename_column :institution_distribution_by_loan_purposes, :personal, :personal_usd
    rename_column :institution_distribution_by_loan_purposes, :other, :other_usd
    change_column :institution_distribution_by_loan_purposes, :microenterprise_usd, :decimal, precision: 17, scale: 2
    change_column :institution_distribution_by_loan_purposes, :sme_usd, :decimal, precision: 17, scale: 2
    change_column :institution_distribution_by_loan_purposes, :corporate_usd, :decimal, precision: 17, scale: 2
    change_column :institution_distribution_by_loan_purposes, :housing_usd, :decimal, precision: 17, scale: 2
    change_column :institution_distribution_by_loan_purposes, :personal_usd, :decimal, precision: 17, scale: 2
    change_column :institution_distribution_by_loan_purposes, :other_usd, :decimal, precision: 17, scale: 2

    remove_column :institution_esg_gender_equalities, :percentage_loans_to_women_borrowers_per_glp, :decimal
    remove_column :institution_esg_gender_equalities, :percentage_women_among_loan_officers, :decimal
    change_column :institution_esg_gender_equalities, :other_usd, :decimal, precision: 18, scale: 2

    remove_column :institution_esg_risks, :tool_use_for_esg_score, :text

    add_column :institution_esg_pai_indicators, :ghg_emissions, :string
    change_column :institution_esg_pai_indicators, :scope_1_emissions, :string, limit: 50
    change_column :institution_esg_pai_indicators, :scope_2_emissions, :string, limit: 50
    change_column :institution_esg_pai_indicators, :scope_3_emissions, :string, limit: 50
    change_column :institution_esg_pai_indicators, :carbon_footprint, :string, limit: 50
    change_column :institution_esg_pai_indicators, :ghg_intensity_investee_companies, :string, limit: 50
    change_column :institution_esg_pai_indicators, :exposure_companies_active_in_fossil_fuel_sector, :string, limit: 50
    change_column :institution_esg_pai_indicators, :share_of_non_renewable_energy_consumption_and_production, :string, limit: 50
    change_column :institution_esg_pai_indicators, :energy_consumption_intensity_per_high_impact_climate_sector, :string, limit: 50
    change_column :institution_esg_pai_indicators, :activities_negatively_affecting_biodiversity_sensitive_areas, :string, limit: 50
    change_column :institution_esg_pai_indicators, :emissions_to_water, :string, limit: 50
    change_column :institution_esg_pai_indicators, :hazardous_waste_ratio, :string, limit: 50
    change_column :institution_esg_pai_indicators, :violations_of_un_global_compact_principles_and_oecd_guidelines_for_multinational_enterprises,
                  :string, limit: 50
    change_column :institution_esg_pai_indicators,
                  :lack_of_processes_and_compliance_mechanisms_to_monitor_compliance_with_un_global_compact_principles, :string, limit: 50
    change_column :institution_esg_pai_indicators, :unadjusted_gender_pay_gap, :string, limit: 50
    change_column :institution_esg_pai_indicators, :board_gender_diversity, :string, limit: 50
    change_column :institution_esg_pai_indicators, :exposure_to_controversial_weapons, :string, limit: 50
  end
end
