class DropFundsUsers < ActiveRecord::Migration[6.0]
  def change
    drop_table :funds_users
  end
end
