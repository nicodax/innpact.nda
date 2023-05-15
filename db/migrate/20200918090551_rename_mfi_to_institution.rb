class RenameMfiToInstitution < ActiveRecord::Migration[6.0]
  def change
    rename_table :mfi_groups, :institution_groups
    rename_table :mfi_types, :institution_types
    rename_column :mfis, :mfi_group_id, :institution_group_id
    rename_column :mfis, :mfi_type_id, :institution_type_id
    rename_table :mfis, :institutions
    rename_column :pool_mfi_groups, :mfi_group_id, :institution_group_id
    rename_table :pool_mfi_groups, :pool_institution_groups
    rename_column :pool_mfi_types, :mfi_type_id, :institution_type_id
    rename_table :pool_mfi_types, :pool_institution_types
    rename_column :pool_mfis, :mfi_id, :institution_id
    rename_table :pool_mfis, :pool_institutions
  end
end
