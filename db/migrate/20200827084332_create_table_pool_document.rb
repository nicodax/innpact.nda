class CreateTablePoolDocument < ActiveRecord::Migration[6.0]
  def change
    create_table :pool_documents do |t|
      t.references :pool, foreign_key: true, null: false
      t.string :document, null: false
      t.string :original_filename, null: false
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
