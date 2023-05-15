class Mef825RemoveDefaultValue < ActiveRecord::Migration[6.0]
  def up
    change_column_null :institution_esg_gender_equalities, :women_percentage_in_board, true
    change_column_null :institution_esg_gender_equalities, :women_percentage_in_staff, true
    change_column_null :institution_esg_gender_equalities, :women_percentage_in_management, true
    change_column_default :institution_esg_gender_equalities, :women_percentage_in_management, nil
    change_column_null :institution_esg_risks, :internal_esg_score, true
    change_column_null :institution_esg_risks, :ifc_esg_risk_financial_intermediaries_classification, true
    drop_table :institution_esg_pai_indicators
    create_table :institution_esg_pai_indicators do |t|
      t.references :institution, null: false
      t.string :ghg_emissions, null: true, limit: 50, default: nil
      t.string :scope_1_emissions, null: true, limit: 50, default: nil
      t.string :scope_2_emissions, null: true, limit: 50, default: nil
      t.string :scope_3_emissions, null: true, limit: 50, default: nil
      t.string :carbon_footprint, null: true, limit: 50, default: nil
      t.string :ghg_intensity_investee_companies, null: true, limit: 50, default: nil
      t.string :exposure_companies_active_in_fossil_fuel_sector, null: true, limit: 50, default: nil
      t.string :share_of_non_renewable_energy_consumption_and_production, null: true, limit: 50, default: nil
      t.string :energy_consumption_intensity_per_high_impact_climate_sector, null: true, limit: 50, default: nil
      t.string :activities_negatively_affecting_biodiversity_sensitive_areas, null: true, limit: 50, default: nil
      t.string :emissions_to_water, null: true, limit: 50, default: nil
      t.string :hazardous_waste_ratio, null: true, limit: 50, default: nil
      t.string :violations_of_un_global_compact_principles_and_oecd_guidelines_for_multinational_enterprises, null: true, limit: 50, default: nil
      t.string :lack_of_processes_and_compliance_mechanisms_to_monitor_compliance_with_un_global_compact_principles, null: true, limit: 50, default: nil
      t.string :unadjusted_gender_pay_gap, null: true, limit: 50, default: nil
      t.string :board_gender_diversity, null: true, limit: 50, default: nil
      t.string :exposure_to_controversial_weapons, null: true, limit: 50, default: nil
      t.datetime :deleted_at
      t.datetime :as_of, default: -> { 'CURRENT_TIMESTAMP' }

      t.timestamps
    end
    add_reference :institution_esg_pai_indicators, :user, foreign_key: true
  end

  def down
    change_column_null :institution_esg_gender_equalities, :women_percentage_in_board, false, 0.0
    change_column_null :institution_esg_gender_equalities, :women_percentage_in_staff, false, 0.0
    change_column_default :institution_esg_gender_equalities, :women_percentage_in_management, 0.0
    change_column_null :institution_esg_gender_equalities, :women_percentage_in_management, false, 0.0
    change_column_null :institution_esg_risks, :internal_esg_score, false
    change_column_null :institution_esg_risks, :ifc_esg_risk_financial_intermediaries_classification, false
    drop_table :institution_esg_pai_indicators
    create_table :institution_esg_pai_indicators do |t|
      t.references :institution, null: false
      t.string :ghg_emissions, null: false, limit: 50, default: ''
      t.string :scope_1_emissions, null: false, limit: 50, default: ''
      t.string :scope_2_emissions, null: false, limit: 50, default: ''
      t.string :scope_3_emissions, null: false, limit: 50, default: ''
      t.string :carbon_footprint, null: false, limit: 50, default: ''
      t.string :ghg_intensity_investee_companies, null: false, limit: 50, default: ''
      t.string :exposure_companies_active_in_fossil_fuel_sector, null: false, limit: 50, default: ''
      t.string :share_of_non_renewable_energy_consumption_and_production, null: false, limit: 50, default: ''
      t.string :energy_consumption_intensity_per_high_impact_climate_sector, null: false, limit: 50, default: ''
      t.string :activities_negatively_affecting_biodiversity_sensitive_areas, null: false, limit: 50, default: ''
      t.string :emissions_to_water, null: false, limit: 50, default: ''
      t.string :hazardous_waste_ratio, null: false, limit: 50, default: ''
      t.string :violations_of_un_global_compact_principles_and_oecd_guidelines_for_multinational_enterprises, null: false, limit: 50, default: ''
      t.string :lack_of_processes_and_compliance_mechanisms_to_monitor_compliance_with_un_global_compact_principles, null: false, limit: 50, default: ''
      t.string :unadjusted_gender_pay_gap, null: false, limit: 50, default: ''
      t.string :board_gender_diversity, null: false, limit: 50, default: ''
      t.string :exposure_to_controversial_weapons, null: false, limit: 50, default: ''
      t.datetime :deleted_at
      t.datetime :as_of, default: -> { 'CURRENT_TIMESTAMP' }, null: false

      t.timestamps
    end
    add_reference :institution_esg_pai_indicators, :user, foreign_key: true
  end
end
