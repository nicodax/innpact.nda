class AddUserToCurrencyRate < ActiveRecord::Migration[6.0]
  def change
    add_reference :currency_rates, :user, null: false, foreign_key: true, default: 1
  end
end
