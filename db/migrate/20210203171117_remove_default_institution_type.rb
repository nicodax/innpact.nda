class RemoveDefaultInstitutionType < ActiveRecord::Migration[6.0]
  def change
    change_column :institutions, :institution_type_id, :bigint, null: false
  end
end
