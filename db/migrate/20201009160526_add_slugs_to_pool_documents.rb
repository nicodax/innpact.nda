class AddSlugsToPoolDocuments < ActiveRecord::Migration[6.0]
  def up
    add_column :pool_documents, :slug, :string
    change_column :pool_documents, :slug, :string, null: false
    add_index :pool_documents, :slug, unique: true

    add_column :pool_legal_documents, :slug, :string
    change_column :pool_legal_documents, :slug, :string, null: false
    add_index :pool_legal_documents, :slug, unique: true
  end

  def down
    remove_column :pool_documents, :slug
    remove_column :pool_legal_documents, :slug
  end
end
