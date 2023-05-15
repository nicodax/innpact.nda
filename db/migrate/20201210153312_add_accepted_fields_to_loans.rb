class AddAcceptedFieldsToLoans < ActiveRecord::Migration[6.0]
  def change
    add_column :loans, :executed_nominal_amount_usd, :float
    add_column :loans, :executed_nominal_amount_local_currency, :float
    add_column :loans, :executed_tenor, :integer
    add_column :loans, :executed_spread, :float
    add_column :loans, :executed_upfront_fees, :float
    add_column :loans, :executed_fixed_rate, :float
    add_column :loans, :disbursement_date, :float
    add_column :loans, :maturity_date, :date
    add_column :loans, :nav_usd, :float
    add_column :loans, :net_position_value_as_of_today, :float
    add_column :loans, :gross_position_value_as_of_today, :float
    add_column :loans, :critical_cases, :string
    add_column :loans, :provision_date, :date
    add_column :loans, :provision_value_usd, :float
    add_column :loans, :interest_rate_type, :string
    add_column :loans, :vrr, :float
    add_column :loans, :vrr_maturity_date, :date
    add_column :loans, :noval, :integer
  end
end
