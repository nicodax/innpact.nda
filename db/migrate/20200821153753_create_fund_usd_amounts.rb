class CreateFundUsdAmounts < ActiveRecord::Migration[6.0]
  def change
    create_table :fund_usd_amounts do |t|
      t.float :amount, null: false
      t.references :fund, foreign_key: true, null: false

      t.timestamps
    end
  end
end
