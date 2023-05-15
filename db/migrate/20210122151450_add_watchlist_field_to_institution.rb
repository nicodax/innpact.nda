class AddWatchlistFieldToInstitution < ActiveRecord::Migration[6.0]
  def change
    add_column :institutions, :in_watchlist, :boolean
    add_column :institutions, :watchlist_reason, :string
    add_column :institutions, :watchlist_entry_date, :date
  end
end
