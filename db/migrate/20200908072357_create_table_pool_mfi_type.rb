class CreateTablePoolMfiType < ActiveRecord::Migration[6.0]
  def change
    create_table :pool_mfi_types do |t|
      t.references :pool, foreign_key: true, null: false
      t.references :mfi_type, foreign_key: true, null: false
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
