class AddDeletedAt < ActiveRecord::Migration[6.0]
  def change
    add_column :pool_countries, :deleted_at, :datetime
    add_column :pool_targets, :deleted_at, :datetime
    add_column :pool_mfis, :deleted_at, :datetime
  end
end
