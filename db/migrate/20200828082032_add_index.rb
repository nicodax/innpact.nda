class AddIndex < ActiveRecord::Migration[6.0]
  def change
    add_index :pools, :deleted_at
    add_index :pool_countries, :deleted_at
    add_index :pool_targets, :deleted_at
    add_index :pool_mfis, :deleted_at
    add_index :pool_documents, :deleted_at
  end
end
