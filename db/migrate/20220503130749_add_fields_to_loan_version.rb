class AddFieldsToLoanVersion < ActiveRecord::Migration[6.0]
  def change
    rename_column :loan_versions, :bond_id, :executed_bond_id
    add_column :loan_versions, :approved_bond_id, :bigint
    rename_column :loan_versions, :interest_rate_type_id, :executed_interest_rate_type_id
    add_column :loan_versions, :approved_interest_rate_type_id, :bigint
    add_column :loan_versions, :number_of_disbursement_date_updates, :integer
  end
end
