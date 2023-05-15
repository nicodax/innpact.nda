class ChangeExecutedFieldsRelatedToHedge < ActiveRecord::Migration[6.0]
  def change
    rename_column :loan_versions, :executed_interest_rate_type_id, :loan_interest_rate_type_id
    rename_column :loan_versions, :executed_spread, :loan_spread
    add_column :archive_v_loans, :loan_interest_rate_type_id, :bigint
    add_column :archive_v_loans, :loan_spread, :float
    update_view :v_loans, version: 10, revert_to_version: 9
  end
end
