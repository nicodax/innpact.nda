class UpdateMonetaryValuesForLoanVersions < ActiveRecord::Migration[6.0]
  def change
    rename_column :loan_versions, :net_position_value_as_of_today, :net_position_value
    rename_column :loan_versions, :gross_position_value_as_of_today, :gross_position_value

    rename_column :loan_versions, :provision_value_usd, :provision_value

    remove_column :loan_versions, :proposed_nominal_amount_usd, :float
    remove_column :loan_versions, :ratified_nominal_amount_usd, :float
    remove_column :loan_versions, :approved_nominal_amount_usd, :float
    remove_column :loan_versions, :executed_nominal_amount_usd, :float
    remove_column :loan_versions, :pending_ratification_nominal_amount_usd, :float
    remove_column :loan_versions, :pending_approval_nominal_amount_usd, :float
    remove_column :loan_versions, :approved_change_request_nominal_amount_usd, :float

    rename_column :loan_versions, :proposed_nominal_amount_local_currency, :proposed_nominal_amount
    rename_column :loan_versions, :ratified_nominal_amount_local_currency, :ratified_nominal_amount
    rename_column :loan_versions, :approved_nominal_amount_local_currency, :approved_nominal_amount
    rename_column :loan_versions, :executed_nominal_amount_local_currency, :executed_nominal_amount
    rename_column :loan_versions, :pending_ratification_nominal_amount_local_currency,
                  :pending_ratification_nominal_amount
    rename_column :loan_versions, :pending_approval_nominal_amount_local_currency, :pending_approval_nominal_amount
    rename_column :loan_versions, :approved_change_request_nominal_amount_local_currency,
                  :approved_change_request_nominal_amount
  end
end
