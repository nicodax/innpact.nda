class AddPropertiesToPool < ActiveRecord::Migration[6.0]
  def change
    add_column :pools, :subscription_date, :date, null: false, default: -> { 'CURRENT_TIMESTAMP' }
    add_column :pools, :has_maturity_date, :boolean, null: false, default: false
    add_column :pools, :maturity_date, :date
    add_column :pools, :amount, :float, null: false, default: 10
    add_reference :pools, :currency, null: false, foreign_key: true, default: 3
    add_column :pools, :amount_in_usd, :float, null: false, default: 12
    add_column :pools, :required_specific_reporting, :boolean, null: false, default: false
  end
end
