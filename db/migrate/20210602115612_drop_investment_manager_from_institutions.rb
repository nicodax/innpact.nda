class DropInvestmentManagerFromInstitutions < ActiveRecord::Migration[6.0]
  def change
    remove_index :institutions, :investment_manager_id
    remove_column :institutions, :investment_manager_id, :bigint
  end
end
