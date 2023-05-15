class AddRegulatoryStatusToInstitution < ActiveRecord::Migration[6.0]
  def change
    add_column :institutions, :regulatory_status, :string
  end
end
