class CreateTableCountryRegions < ActiveRecord::Migration[6.0]
  def change
    create_table :country_regions do |t|
      t.references :country, foreign_key: true, null: false
      t.references :region, foreign_key: true, null: false
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
