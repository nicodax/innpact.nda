class AddColumnsInArchiveVLoans < ActiveRecord::Migration[6.0]
  def change
    add_column :archive_v_loans, :executed_bond_id, :bigint
    add_column :archive_v_loans, :executed_interest_rate_type_id, :bigint
    add_column :archive_v_loans, :approved_bond_id, :bigint
    add_column :archive_v_loans, :approved_interest_rate_type_id, :bigint
    add_column :archive_v_loans, :number_of_disbursement_date_updates, :integer
    add_column :archive_v_loans, :invested_hedge_fx_rate, :decimal, precision: 18, scale: 9
  end
end
