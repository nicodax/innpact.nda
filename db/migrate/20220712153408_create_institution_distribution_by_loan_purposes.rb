class CreateInstitutionDistributionByLoanPurposes < ActiveRecord::Migration[6.0]
  def up
    create_table :institution_distribution_by_loan_purposes do |t|
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
  def down
    drop_table :institution_distribution_by_loan_purposes
  end
end
