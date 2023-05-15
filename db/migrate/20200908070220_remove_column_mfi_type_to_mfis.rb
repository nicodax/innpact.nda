class RemoveColumnMfiTypeToMfis < ActiveRecord::Migration[6.0]
  def change
    remove_column :mfis, :institution_type, :string
    add_reference :mfis, :mfi_type, null: false, foreign_key: true, default: 1
  end
end
