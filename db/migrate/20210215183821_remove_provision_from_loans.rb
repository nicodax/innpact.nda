class RemoveProvisionFromLoans < ActiveRecord::Migration[6.0]
  def change
    remove_column :loans, :provision, :boolean
  end
end
