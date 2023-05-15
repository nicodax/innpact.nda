class AddDeletedAtToFunds < ActiveRecord::Migration[6.0]
  def change
    add_column :funds, :deleted_at, :datetime
    add_index :funds, :deleted_at
  end
end
