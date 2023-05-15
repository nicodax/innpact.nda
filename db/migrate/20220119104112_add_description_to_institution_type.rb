class AddDescriptionToInstitutionType < ActiveRecord::Migration[6.0]
  def change
    add_column :institution_types, :description, :string
  end
end
