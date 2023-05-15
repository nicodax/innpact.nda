class AddColumnToPoolTarget < ActiveRecord::Migration[6.0]
  def change
    change_column :pool_targets, :value, :decimal, precision: 17, scale: 2
    rename_column :pool_targets, :value, :amount_in_usd
    add_column :pool_targets, :amount_in_percent, :decimal, precision: 5, scale: 2
  end
end
