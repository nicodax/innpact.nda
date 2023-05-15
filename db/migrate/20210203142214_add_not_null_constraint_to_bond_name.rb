class AddNotNullConstraintToBondName < ActiveRecord::Migration[6.0]
  def change
    change_column :bonds, :name, :string, null: false
    change_column :bonds, :description, :string, null: false
  end
end
