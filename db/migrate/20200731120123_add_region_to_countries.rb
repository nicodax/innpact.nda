class AddRegionToCountries < ActiveRecord::Migration[6.0]
  def change
    remove_column :countries, :region, :string
    add_reference :countries, :region, null: false, foreign_key: true
  end
end
