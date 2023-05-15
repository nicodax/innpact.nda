class AddStatusFields < ActiveRecord::Migration[6.0]
  def change
    add_column :loans, :pending_ratification_nominal_amount_usd, :float
    add_column :loans, :pending_ratification_nominal_amount_local_currency, :float
    add_column :loans, :pending_ratification_tenor, :integer
    add_column :loans, :pending_ratification_spread, :float
    add_column :loans, :pending_ratification_upfront_fees, :float
    add_column :loans, :pending_ratification_fixed_rate, :float
    add_column :loans, :pending_approval_nominal_amount_usd, :float
    add_column :loans, :pending_approval_nominal_amount_local_currency, :float
    add_column :loans, :pending_approval_tenor, :integer
    add_column :loans, :pending_approval_spread, :float
    add_column :loans, :pending_approval_upfront_fees, :float
    add_column :loans, :pending_approval_fixed_rate, :float
    add_column :loans, :approved_change_request_nominal_amount_usd, :float
    add_column :loans, :approved_change_request_nominal_amount_local_currency, :float
    add_column :loans, :approved_change_request_tenor, :integer
    add_column :loans, :approved_change_request_spread, :float
    add_column :loans, :approved_change_request_upfront_fees, :float
    add_column :loans, :approved_change_request_fixed_rate, :float
  end
end
