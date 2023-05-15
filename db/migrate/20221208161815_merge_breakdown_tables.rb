class MergeBreakdownTables < ActiveRecord::Migration[6.0]
  def change
    # institution_distribution_by_sectors
    change_table :institution_specific_breakdowns do |t|
      t.decimal :production, precision: 17, scale: 2
      t.decimal :agriculture, precision: 17, scale: 2
      t.decimal :consumption, precision: 17, scale: 2
      t.decimal :by_sector_other, precision: 17, scale: 2
      t.decimal :trade_and_services, precision: 17, scale: 2
    end

    drop_table :institution_distribution_by_sectors do |t|
      t.references :institution, null: false
      t.references :user, foreign_key: true
      t.decimal :production, precision: 17, scale: 2
      t.decimal :agriculture, precision: 17, scale: 2
      t.decimal :consumption, precision: 17, scale: 2
      t.decimal :other, precision: 17, scale: 2
      t.decimal :trade_and_services, precision: 17, scale: 2
      t.datetime :deleted_at
      t.datetime :as_of, default: -> { 'CURRENT_TIMESTAMP' }
      t.timestamps
    end

    # institution_distribution_by_loan_purposes
    change_table :institution_specific_breakdowns do |t|
      t.decimal :microenterprise, precision: 18, scale: 2
      t.decimal :sme, precision: 18, scale: 2
      t.decimal :corporate, precision: 18, scale: 2
      t.decimal :housing, precision: 18, scale: 2
      t.decimal :personal, precision: 18, scale: 2
      t.decimal :by_loan_purpose_other, precision: 18, scale: 2
    end

    drop_table :institution_distribution_by_loan_purposes do |t|
      t.references :institution, null: false
      t.references :user, foreign_key: true
      t.decimal :microenterprise_usd, precision: 18, scale: 2
      t.decimal :sme_usd, precision: 18, scale: 2
      t.decimal :corporate_usd, precision: 18, scale: 2
      t.decimal :housing_usd, precision: 18, scale: 2
      t.decimal :personal_usd, precision: 18, scale: 2
      t.decimal :other_usd, precision: 18, scale: 2
      t.datetime :deleted_at
      t.datetime :as_of, default: -> { 'CURRENT_TIMESTAMP' }
      t.timestamps
    end
  end
end
