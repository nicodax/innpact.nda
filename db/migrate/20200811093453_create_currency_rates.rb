class CreateCurrencyRates < ActiveRecord::Migration[6.0]
  def change
    create_table :currency_rates do |t|
      t.string :currency
      t.float :rate

      t.timestamps
    end
  end
end
