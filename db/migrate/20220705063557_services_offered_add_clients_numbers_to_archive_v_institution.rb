class ServicesOfferedAddClientsNumbersToArchiveVInstitution < ActiveRecord::Migration[6.0]
  def change
    add_column :archive_v_institutions, :voluntary_savings, :boolean
    add_column :archive_v_institutions, :number_clients_using_mobile_banking, :integer
    add_column :archive_v_institutions, :number_clients_with_deposits, :integer
  end
end
