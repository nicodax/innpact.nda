class MigrateFloatsToDecimal < ActiveRecord::Migration[6.0]
  def up
    change_column :currency_rates, :rate, :decimal, precision: 17, scale: 6

    change_column :repayment_calendar_lines, :original_amount, :decimal, precision: 17, scale: 2, null: false
    change_column :repayment_calendar_lines, :received_amount, :decimal, precision: 17, scale: 2,
                                                                         default: 0, null: false
    change_column :repayment_calendar_lines, :provision, :decimal, precision: 17, scale: 2,
                                                                   default: 0, null: false

    change_column :loan_versions, :proposed_nominal_amount, :decimal, precision: 17, scale: 2
    change_column :loan_versions, :ratified_nominal_amount, :decimal, precision: 17, scale: 2
    change_column :loan_versions, :approved_nominal_amount, :decimal, precision: 17, scale: 2
    change_column :loan_versions, :executed_nominal_amount, :decimal, precision: 17, scale: 2
    change_column :loan_versions, :pending_ratification_nominal_amount, :decimal, precision: 17, scale: 2
    change_column :loan_versions, :pending_approval_nominal_amount, :decimal, precision: 17, scale: 2
    change_column :loan_versions, :approved_change_request_nominal_amount, :decimal, precision: 17, scale: 2
    change_column :loan_versions, :provision_value, :decimal, precision: 17, scale: 2
    change_column :loan_versions, :gross_position_value, :decimal, precision: 17, scale: 2
    change_column :loan_versions, :net_position_value, :decimal, precision: 17, scale: 2

    change_column :pools, :amount, :decimal, precision: 17, scale: 2, default: 10, null: false
    change_column :pools, :amount_in_usd, :decimal, precision: 17, scale: 2, default: 12, null: false
  end

  def down
    change_column :pools, :amount, :float
    change_column :pools, :amount_in_usd, :float

    change_column :loan_versions, :proposed_nominal_amount, :float
    change_column :loan_versions, :ratified_nominal_amount, :float
    change_column :loan_versions, :approved_nominal_amount, :float
    change_column :loan_versions, :executed_nominal_amount, :float
    change_column :loan_versions, :pending_ratification_nominal_amount, :float
    change_column :loan_versions, :pending_approval_nominal_amount, :float
    change_column :loan_versions, :approved_change_request_nominal_amount, :float
    change_column :loan_versions, :provision_value, :float
    change_column :loan_versions, :gross_position_value, :float
    change_column :loan_versions, :net_position_value, :float

    change_column :repayment_calendar_lines, :original_amount, :float
    change_column :repayment_calendar_lines, :received_amount, :float
    change_column :repayment_calendar_lines, :provision, :float

    change_column :currency_rates, :rate, :float
  end
end
