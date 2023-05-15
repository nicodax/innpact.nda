class AddHedgeFieldsToLoanVersion < ActiveRecord::Migration[6.0]
  def change
    add_column :loan_versions, :hedge_spread, :float
    add_column :loan_versions, :hedge_interest_rate_type_id, :bigint
    rename_column :loan_versions, :invested_hedge, :hedge_comment
  end
end
