class AddFieldsToArchiveVLoans < ActiveRecord::Migration[6.0]
  def change
    add_column :archive_v_loans, :hedge_spread, :float
    add_column :archive_v_loans, :hedge_interest_rate_type_id, :bigint
    rename_column :archive_v_loans, :invested_hedge, :hedge_comment
  end
end
