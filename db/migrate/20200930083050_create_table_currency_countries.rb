class CreateTableCurrencyCountries < ActiveRecord::Migration[6.0]
  def change
    create_table :currency_countries do |t|
      t.references :currency, foreign_key: true, null: false
      t.references :country, foreign_key: true, null: false
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
