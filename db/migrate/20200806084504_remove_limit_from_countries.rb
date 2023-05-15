class RemoveLimitFromCountries < ActiveRecord::Migration[6.0]
  def change
    remove_column :countries, :limit, :integer
  end
end
