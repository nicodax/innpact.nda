class AddDetailsToFunds < ActiveRecord::Migration[6.0]
  def change
    add_column :funds, :details, :text
  end
end
