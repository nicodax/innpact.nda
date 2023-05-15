class CreateLoanSdgData < ActiveRecord::Migration[6.0]
  def change
    create_table :loan_sdg_data do |t|
      t.belongs_to :loan, null: false, foreign_key: true
      t.boolean :no_poverty, null: false, default: false
      t.boolean :zero_hunger, null: false, default: false
      t.boolean :good_health_and_wellbeing, null: false, default: false
      t.boolean :quality_education, null: false, default: false
      t.boolean :gender_equality, null: false, default: false
      t.boolean :clean_water_and_sanitation, null: false, default: false
      t.boolean :affordable_and_clean_energy, null: false, default: false
      t.boolean :descent_work_and_economic_growth, null: false, default: false
      t.boolean :industry_innovation_and_infrastructure, null: false, default: false
      t.boolean :reduced_inequalities, null: false, default: false
      t.boolean :sustainable_cities_and_conmmunities, null: false, default: false
      t.boolean :responsible_consumption_and_production, null: false, default: false
      t.boolean :climate_action, null: false, default: false
      t.boolean :life_below_water, null: false, default: false
      t.boolean :life_on_land, null: false, default: false
      t.boolean :peace_justice_and_strong_institutions, null: false, default: false
      t.boolean :partnerships_for_the_goals, null: false, default: false
      t.datetime :deleted_at
    end
  end
end
