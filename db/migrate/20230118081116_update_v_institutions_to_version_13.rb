class UpdateVInstitutionsToVersion13 < ActiveRecord::Migration[6.0]
  def change
    update_view :v_institutions, version: 13, revert_to_version: 12

    # Institution
    add_column :archive_v_institutions, :use_of_standard_reporting_tools_sptf_alinus, :string

    # rating
    add_column :archive_v_institutions, :rating_as_of, :datetime

    # institution_financials
    add_column :archive_v_institutions, :npls_USD, :decimal, precision: 18, scale: 2
    add_column :archive_v_institutions, :write_off_USD, :decimal, precision: 18, scale: 2

    # institution_specific_breakdowns
    add_column :archive_v_institutions, :institution_specific_breakdowns_as_of, :datetime
    add_column :archive_v_institutions, :sector_trade_and_services_percent, :decimal, precision: 5, scale: 2
    add_column :archive_v_institutions, :agriculture_percent, :decimal, precision: 5, scale: 2
    add_column :archive_v_institutions, :production_percent, :decimal, precision: 5, scale: 2
    add_column :archive_v_institutions, :consumption_percent, :decimal, precision: 5, scale: 2
    add_column :archive_v_institutions, :by_sector_other_percent, :decimal, precision: 5, scale: 2

    add_column :archive_v_institutions, :loan_purpose_microenterprise_percent, :decimal, precision: 5, scale: 2
    add_column :archive_v_institutions, :loan_purpose_sme_percent, :decimal, precision: 5, scale: 2
    add_column :archive_v_institutions, :loan_purpose_corporate_percent, :decimal, precision: 5, scale: 2
    add_column :archive_v_institutions, :loan_purpose_housing_percent, :decimal, precision: 5, scale: 2
    add_column :archive_v_institutions, :loan_purpose_personal_percent, :decimal, precision: 5, scale: 2
    add_column :archive_v_institutions, :loan_purpose_other_percent, :decimal, precision: 5, scale: 2

    # institution_impact_indicators
    add_column :archive_v_institutions, :impact_indicator_as_of_date, :datetime
    add_column :archive_v_institutions, :internal_impact_score, :string
    add_column :archive_v_institutions, :number_of_clients, :integer

    # positive_impact_services_offereds
    add_column :archive_v_institutions, :services_offered_as_of_date, :datetime

    # institution_esg_gender_equalities
    add_column :archive_v_institutions, :esg_gender_equalities_as_of_date, :datetime
    add_column :archive_v_institutions, :women_percentage_in_board, :decimal, precision: 5, scale: 2
    add_column :archive_v_institutions, :women_percentage_in_management, :decimal, precision: 5, scale: 2
    add_column :archive_v_institutions, :women_percentage_in_staff, :decimal, precision: 5, scale: 2
    add_column :archive_v_institutions, :percentage_women_among_loan_officers, :decimal, precision: 5, scale: 2
    add_column :archive_v_institutions, :financial_services_targeting_women, :decimal, precision: 5, scale: 2
    add_column :archive_v_institutions, :non_financial_services_targeting_women, :decimal, precision: 5, scale: 2

    # institution_esg_risks
    add_column :archive_v_institutions, :esg_risk_as_of, :datetime
    add_column :archive_v_institutions, :tool_use_for_esg_score, :text
    add_column :archive_v_institutions, :internal_esg_score, :string, limit: 10
    add_column :archive_v_institutions, :ifc_esg_risk_financial_intermediaries_classification, :string
    add_column :archive_v_institutions, :esms_in_place_commensurate_with_risk_profile, :boolean

    # institution_esg_safeguards
    add_column :archive_v_institutions, :esg_safeguards_as_of, :datetime
    add_column :archive_v_institutions, :compliance_with_fund_exclusion_list, :boolean
    add_column :archive_v_institutions, :compliance_with_international_labour_organization_standards, :boolean
    add_column :archive_v_institutions, :compliance_with_international_bill_of_human_rights, :boolean
    add_column :archive_v_institutions, :compliance_with_guiding_principles_on_business_and_human_rights, :boolean
    add_column :archive_v_institutions, :compliance_with_oecd_guidelines_for_multinational_enterprises, :boolean
    add_column :archive_v_institutions, :compliance_with_national_standards_and_law, :boolean
    add_column :archive_v_institutions, :compliance_with_client_protection_principles, :boolean

    # institution_esg_pai_indicators
    add_column :archive_v_institutions, :pai_indicator_as_of, :datetime
    add_column :archive_v_institutions, :scope_1_emissions, :decimal, precision: 18, scale: 2
    add_column :archive_v_institutions, :scope_2_emissions, :decimal, precision: 18, scale: 2
    add_column :archive_v_institutions, :scope_3_emissions, :decimal, precision: 18, scale: 2
    add_column :archive_v_institutions, :carbon_footprint, :decimal, precision: 18, scale: 2
    add_column :archive_v_institutions, :ghg_intensity_investee_companies, :decimal, precision: 18, scale: 2
    add_column :archive_v_institutions, :exposure_companies_active_in_fossil_fuel_sector, :decimal, precision: 5, scale: 2
    add_column :archive_v_institutions, :share_of_non_renewable_energy_consumption_and_production, :decimal, precision: 5, scale: 2
    add_column :archive_v_institutions, :energy_consumption_intensity_per_high_impact_climate_sector, :decimal, precision: 18, scale: 2
    add_column :archive_v_institutions, :activities_negatively_affecting_biodiversity_sensitive_areas, :decimal, precision: 5, scale: 2
    add_column :archive_v_institutions, :emissions_to_water, :decimal, precision: 18, scale: 2
    add_column :archive_v_institutions, :hazardous_waste_ratio, :decimal, precision: 18, scale: 2
    add_column :archive_v_institutions, :violations_of_un_global_compact_principles_and_oecd_guidelines_for_multinational_enterprises, :decimal, precision: 5, scale: 2
    add_column :archive_v_institutions, :lack_of_processes_and_compliance_mechanisms_to_monitor_compliance_with_un_global_compact_principles, :decimal, precision: 5, scale: 2
    add_column :archive_v_institutions, :unadjusted_gender_pay_gap, :decimal, precision: 5, scale: 2
    add_column :archive_v_institutions, :board_gender_diversity, :decimal, precision: 5, scale: 2
    add_column :archive_v_institutions, :exposure_to_controversial_weapons, :decimal, precision: 5, scale: 2
  end
end
