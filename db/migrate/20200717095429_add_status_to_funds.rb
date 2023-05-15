class AddStatusToFunds < ActiveRecord::Migration[6.0]
  def change
    add_column :funds, :status, :integer
  end
end
