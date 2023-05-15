class AddForeignKeyFromCurrencyRateToCurrency < ActiveRecord::Migration[6.0]
  def change
    CurrencyRate.with_deleted.where(currency: nil).each(&:really_destroy!)
    change_column :currency_rates, :currency_id, :bigint
    add_foreign_key :currency_rates, :currencies
  end
end
