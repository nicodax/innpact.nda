class CreateJoinTable < ActiveRecord::Migration[6.0]
  def change
    create_table :pool_countries do |t|
      t.references :pool, foreign_key: true, null: false
      t.references :country, foreign_key: true, null: false

      t.timestamps
    end
    create_table :pool_mfis do |t|
      t.references :pool, foreign_key: true, null: false
      t.references :mfi, foreign_key: true, null: false

      t.timestamps
    end
  end
end
