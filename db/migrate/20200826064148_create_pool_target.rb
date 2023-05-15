class CreatePoolTarget < ActiveRecord::Migration[6.0]
  def change
    create_table :pool_targets do |t|
      t.float :value, null: false
      t.references :pool, foreign_key: true, null: false

      t.timestamps
    end
  end
end
