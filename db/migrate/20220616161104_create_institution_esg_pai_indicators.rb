class CreateInstitutionEsgPaiIndicators < ActiveRecord::Migration[6.0]
  def up
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
      t.datetime :as_of, default: DateTime.now, null: false

      t.timestamps
    end
  end
  def down
    drop_table :institution_esg_pai_indicators
  end
end
