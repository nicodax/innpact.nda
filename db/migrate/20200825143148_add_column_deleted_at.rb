class AddColumnDeletedAt < ActiveRecord::Migration[6.0]
  def change
    add_column :pools, :deleted_at, :datetime
  end
end
