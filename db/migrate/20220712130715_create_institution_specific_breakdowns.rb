class CreateInstitutionSpecificBreakdowns < ActiveRecord::Migration[6.0]
  def up
    create_table :institution_specific_breakdowns do |t|
      t.references :institution, null: false
      t.references :user, foreign_key: true
      t.decimal :microfinance_portfolio_size, precision: 18, scale: 2
      t.decimal :sme_portfolio_size_under_35k, precision: 18, scale: 2
      t.decimal :sme_portfolio_size_under_50k, precision: 18, scale: 2
      t.decimal :percentage_rural_ptf, precision: 5, scale: 2
      t.decimal :percentage_of_women_ptf, precision: 5, scale: 2
      t.datetime :deleted_at
      t.datetime :as_of, default: -> { 'CURRENT_TIMESTAMP' }
      t.timestamps
    end
  end
  def down
    drop_table :institution_specific_breakdowns
  end
end
