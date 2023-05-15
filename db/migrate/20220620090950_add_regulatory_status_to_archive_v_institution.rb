class AddRegulatoryStatusToArchiveVInstitution < ActiveRecord::Migration[6.0]
  def change
    add_column :archive_v_institutions, :regulatory_status, :string
  end
end
