class AdaptCurrencyRates < ActiveRecord::Migration[6.0]
  def change
    rename_column :currency_rates, :currency, :currency_name
    add_column :currency_rates, :currency_id, :integer # , null: false, foreign_key: true # TODO: TinyTDS refuses notnull constraint on non-empty tables.
    remove_column :currency_rates, :currency_name, :string
  end
end
