class ChangeRegionToCountryGroups < ActiveRecord::Migration[6.0]
  def change
    rename_column :country_regions, :region_id, :country_group_id
    rename_table :country_regions, :country_country_groups
    rename_column :pool_regions, :region_id, :country_group_id
    rename_table :pool_regions, :pool_country_groups
    rename_table :regions, :country_groups
  end
end
