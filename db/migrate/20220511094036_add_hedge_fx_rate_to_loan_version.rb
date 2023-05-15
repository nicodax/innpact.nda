class AddHedgeFxRateToLoanVersion < ActiveRecord::Migration[6.0]
  def change
    add_column :loan_versions, :invested_hedge_fx_rate, :decimal, precision: 18, scale: 9
  end
end
