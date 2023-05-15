class AddColumnIsGlobalToPool < ActiveRecord::Migration[6.0]
  def change
    add_column :pools, :is_targeted, :boolean, null: false, default: false
  end
end
