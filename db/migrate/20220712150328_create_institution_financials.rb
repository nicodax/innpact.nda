class CreateInstitutionFinancials < ActiveRecord::Migration[6.0]
  def up
    create_table :institution_financials do |t|
      t.references :institution, null: false
      t.references :user, foreign_key: true
      t.decimal :liabilities, precision: 18, scale: 2
      t.decimal :domestic_liabilities, precision: 18, scale: 2
      t.decimal :international_liabilities, precision: 18, scale: 2
      t.decimal :revenues, precision: 18, scale: 2
      t.decimal :net_income_distributed_as_dividends, precision: 17, scale: 2
      t.decimal :provision_for_loss, precision: 18, scale: 2
      t.decimal :write_off, precision: 5, scale: 2
      t.decimal :deposit_amount, precision: 18, scale: 2
      t.decimal :total_assets, precision: 18, scale: 2
      t.decimal :gross_loan_portfolio, precision: 18, scale: 2
      t.decimal :equity, precision: 18, scale: 2
      t.decimal :net_income, precision: 18, scale: 2
      t.decimal :npls, precision: 5, scale: 2
      t.datetime :deleted_at
      t.datetime :as_of, default: -> { 'CURRENT_TIMESTAMP' }
      t.timestamps
    end
  end
  def down
    drop_table :institution_financials
  end
end
