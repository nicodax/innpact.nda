class DropCountryCountryGroup < ActiveRecord::Migration[6.0]
  def change
    drop_table :country_country_groups
  end
end
