class AddCountryGroupToCountry < ActiveRecord::Migration[6.0]
  def change
    add_column :countries, :country_group_id, :bigint, default: nil
    add_foreign_key :countries, :country_groups, on_delete: :nullify
    add_index :countries, :country_group_id, where: 'country_group_id IS NOT NULL'
  end
end
