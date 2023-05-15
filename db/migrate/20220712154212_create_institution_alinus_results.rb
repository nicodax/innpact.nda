class CreateInstitutionAlinusResults < ActiveRecord::Migration[6.0]
  def up
    create_table :institution_alinus_results do |t|
      t.references :institution, null: false
      t.references :user, foreign_key: true
      t.boolean :has_sptf_alinus_reporting_using_alinus
      t.string :sptf_alinus_reporting_using_alinus, limit: 15
      t.decimal :overall_sptf_alinus_score, precision: 5, scale: 2
      t.decimal :define_and_monitor_social_goals, precision: 5, scale: 2
      t.decimal :ensure_commitment_to_social_goals, precision: 5, scale: 2
      t.decimal :product_design_to_meet_clients_need, precision: 5, scale: 2
      t.decimal :treat_clients_responsibly, precision: 5, scale: 2
      t.decimal :treat_employees_responsibly, precision: 5, scale: 2
      t.decimal :balance_financial_and_performance, precision: 5, scale: 2
      t.decimal :promote_environmental_protection, precision: 5, scale: 2
      t.datetime :deleted_at
      t.datetime :as_of, default: -> { 'CURRENT_TIMESTAMP' }
      t.timestamps
    end
  end
  def down
    drop_table :institution_alinus_results
  end
end
