class UpdateLoanColumns < ActiveRecord::Migration[6.0]
  def change
    remove_column :loans, :appetite_inquiry_nominal_amount_usd
    remove_column :loans, :appetite_inquiry_nominal_amount_local_currency
    remove_column :loans, :appetite_inquiry_tenor
    remove_column :loans, :appetite_inquiry_spread
    remove_column :loans, :appetite_inquiry_upfront_fees
    remove_column :loans, :appetite_inquiry_fixed_rate

    add_column :loans, :pending_ratification_date, :date
    add_column :loans, :deadline_pending_ratification_date, :date
    add_column :loans, :pending_approval_date, :date
    add_column :loans, :deadline_pending_approval_date, :date
  end
end
