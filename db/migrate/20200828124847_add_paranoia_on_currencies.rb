class AddParanoiaOnCurrencies < ActiveRecord::Migration[6.0]
  def change
    add_column :currencies, :deleted_at, :datetime
    add_column :currency_rates, :deleted_at, :datetime

    add_index :currencies, :deleted_at
    add_index :currency_rates, :deleted_at
  end
end
