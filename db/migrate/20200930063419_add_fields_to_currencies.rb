class AddFieldsToCurrencies < ActiveRecord::Migration[6.0]
  def change
    rename_column :currencies, :name, :short_name
    rename_column :currencies, :description, :name
    add_reference :currencies, :country, index: true, foreign_key: true
  end
end
