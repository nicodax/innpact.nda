class ServicesOfferedAddClientsNumbers < ActiveRecord::Migration[6.0]
  def change
    add_column :institutions, :voluntary_savings, :boolean
    add_column :institutions, :number_clients_using_mobile_banking, :integer
    add_column :institutions, :number_clients_with_deposits, :integer
  end
end
