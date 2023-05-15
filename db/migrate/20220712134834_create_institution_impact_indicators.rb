class CreateInstitutionImpactIndicators < ActiveRecord::Migration[6.0]
  def up
    create_table :institution_impact_indicators do |t|
      t.references :institution, null: false
      t.references :user, foreign_key: true
      t.bigint :borrowers_count
      t.bigint :female_borrowers_count
      t.bigint :rural_borrowers_count
      t.bigint :number_of_micro_borrowers
      t.bigint :number_of_sme_borrowers
      t.decimal :avg_loan_size, precision: 18, scale: 2
      t.string :internal_impact_score
      t.integer :number_of_clients
      t.datetime :deleted_at
      t.datetime :as_of, default: -> { 'CURRENT_TIMESTAMP' }
      t.timestamps
    end
  end
  def down
    drop_table :institution_impact_indicators
  end
end
