class AddAppetiteInquiryAttributes < ActiveRecord::Migration[6.0]
  def change
    add_column :loans, :appetite_inquiry_nominal_amount_usd, :float
    add_column :loans, :appetite_inquiry_nominal_amount_local_currency, :float
    add_column :loans, :appetite_inquiry_tenor, :integer
    add_column :loans, :appetite_inquiry_spread, :float
    add_column :loans, :appetite_inquiry_upfront_fees, :float
    add_column :loans, :appetite_inquiry_fixed_rate, :float
  end
end
