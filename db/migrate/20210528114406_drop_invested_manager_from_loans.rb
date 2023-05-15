class DropInvestedManagerFromLoans < ActiveRecord::Migration[6.0]
  def change
    remove_index :loans, :investment_manager_id
    remove_column :loans, :investment_manager_id, :bigint
  end
end
