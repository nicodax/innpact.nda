class AddColumnPriorityToCurrencies < ActiveRecord::Migration[6.0]
  def change
    add_column :currencies, :priority, :integer
  end
end
