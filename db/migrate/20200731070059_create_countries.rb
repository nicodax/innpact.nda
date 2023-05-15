class CreateCountries < ActiveRecord::Migration[6.0]
  def change
    create_table :countries do |t|
      t.string :name
      t.string :region
      t.decimal :limit
      t.belongs_to :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
