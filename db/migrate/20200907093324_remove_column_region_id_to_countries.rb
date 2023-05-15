class RemoveColumnRegionIdToCountries < ActiveRecord::Migration[6.0]
  def change
    remove_column :countries, :region_id
  end
end
