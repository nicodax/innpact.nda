class AddDeletedAtToFundUsdAmounts < ActiveRecord::Migration[6.0]
  def change
    add_column :fund_usd_amounts, :deleted_at, :datetime
  end
end
