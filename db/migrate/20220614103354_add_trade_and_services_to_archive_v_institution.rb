class AddTradeAndServicesToArchiveVInstitution < ActiveRecord::Migration[6.0]
  def change
    add_column :archive_v_institutions, :trade_and_services, :decimal, precision: 5, scale: 2
  end
end
