class AddExpiredDateToCurrencyRates < ActiveRecord::Migration[6.0]
  def change
    add_column :currency_rates, :expired_date, :date
  end
end
