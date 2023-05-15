class AddDeletedAtToFundsUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :funds_users, :deleted_at, :datetime
    add_index :funds_users, :deleted_at
  end
end
