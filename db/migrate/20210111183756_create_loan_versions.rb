class CreateLoanVersions < ActiveRecord::Migration[6.0]
  def up
    create_table :loan_versions do |t|
      t.references :loan, null: false
      t.integer :version_number, default: 1, null: false
      t.string :status, null: false
      t.string :version_status, null: false, default: 'temporary'
      t.references :currency, foreign_key: true
      t.references :loan_type, foreign_key: true
      t.references :repayment_type, foreign_key: true
      t.references :creation_user, null: false, foreign_key: { to_table: :users }
      t.date :assignment_date
      t.date :deadline_assignment_date
      t.date :ratification_date
      t.date :deadline_ratification_date
      t.date :approval_date
      t.date :deadline_approval_date
      t.date :expected_disbursement_date
      t.string :specific_approval_condition
      t.float :probabilities
      t.string :bond
      t.date :disbursement_date
      t.boolean :in_waiting_list, default: false, null: false
      t.date :maturity_date
      t.float :nav_usd
      t.float :net_position_value_as_of_today
      t.float :gross_position_value_as_of_today
      t.string :critical_cases
      t.date :provision_date
      t.float :provision_value_usd
      t.string :interest_rate_type
      t.float :vrr
      t.date :vrr_maturity_date
      t.float :proposed_nominal_amount_usd
      t.float :proposed_nominal_amount_local_currency
      t.integer :proposed_tenor
      t.float :proposed_spread
      t.float :proposed_upfront_fees
      t.float :proposed_fixed_rate
      t.float :ratified_nominal_amount_usd
      t.float :ratified_nominal_amount_local_currency
      t.integer :ratified_tenor
      t.float :ratified_spread
      t.float :ratified_upfront_fees
      t.float :ratified_fixed_rate
      t.float :approved_nominal_amount_usd
      t.float :approved_nominal_amount_local_currency
      t.integer :approved_tenor
      t.float :approved_spread
      t.float :approved_upfront_fees
      t.float :approved_fixed_rate
      t.float :executed_nominal_amount_usd
      t.float :executed_nominal_amount_local_currency
      t.integer :executed_tenor
      t.float :executed_spread
      t.float :executed_upfront_fees
      t.float :executed_fixed_rate
      t.float :pending_ratification_nominal_amount_usd
      t.float :pending_ratification_nominal_amount_local_currency
      t.integer :pending_ratification_tenor
      t.float :pending_ratification_spread
      t.float :pending_ratification_upfront_fees
      t.float :pending_ratification_fixed_rate
      t.date :pending_ratification_date
      t.date :deadline_pending_ratification_date
      t.float :pending_approval_nominal_amount_usd
      t.float :pending_approval_nominal_amount_local_currency
      t.integer :pending_approval_tenor
      t.float :pending_approval_spread
      t.float :pending_approval_upfront_fees
      t.float :pending_approval_fixed_rate
      t.date :pending_approval_date
      t.date :deadline_pending_approval_date
      t.float :approved_change_request_nominal_amount_usd
      t.float :approved_change_request_nominal_amount_local_currency
      t.integer :approved_change_request_tenor
      t.float :approved_change_request_spread
      t.float :approved_change_request_upfront_fees
      t.float :approved_change_request_fixed_rate
      t.date :approval_change_request_date
      t.date :deadline_approval_change_request_date
      t.references :validation_user, foreign_key: { to_table: :users }
      t.references :rejection_user, foreign_key: { to_table: :users }
      t.timestamps
      t.date :deleted_at
    end

    add_column :loans, :last_loan_version, :integer, null: false, default: 0

    remove_column :loans, :status
    remove_column :loans, :currency_id
    remove_column :loans, :loan_type_id
    remove_column :loans, :repayment_type_id
    remove_column :loans, :assignment_date
    remove_column :loans, :deadline_assignment_date
    remove_column :loans, :ratification_date
    remove_column :loans, :deadline_ratification_date
    remove_column :loans, :approval_date
    remove_column :loans, :deadline_approval_date
    remove_column :loans, :expected_disbursement_date
    remove_column :loans, :specific_approval_condition
    remove_column :loans, :probabilities
    remove_column :loans, :bond
    remove_column :loans, :disbursement_date
    remove_column :loans, :in_waiting_list
    remove_column :loans, :maturity_date
    remove_column :loans, :nav_usd
    remove_column :loans, :net_position_value_as_of_today
    remove_column :loans, :gross_position_value_as_of_today
    remove_column :loans, :critical_cases
    remove_column :loans, :provision_date
    remove_column :loans, :provision_value_usd
    remove_column :loans, :interest_rate_type
    remove_column :loans, :vrr
    remove_column :loans, :vrr_maturity_date
    remove_column :loans, :proposed_nominal_amount_usd
    remove_column :loans, :proposed_nominal_amount_local_currency
    remove_column :loans, :proposed_tenor
    remove_column :loans, :proposed_spread
    remove_column :loans, :proposed_upfront_fees
    remove_column :loans, :proposed_fixed_rate
    remove_column :loans, :ratified_nominal_amount_usd
    remove_column :loans, :ratified_nominal_amount_local_currency
    remove_column :loans, :ratified_tenor
    remove_column :loans, :ratified_spread
    remove_column :loans, :ratified_upfront_fees
    remove_column :loans, :ratified_fixed_rate
    remove_column :loans, :approved_nominal_amount_usd
    remove_column :loans, :approved_nominal_amount_local_currency
    remove_column :loans, :approved_tenor
    remove_column :loans, :approved_spread
    remove_column :loans, :approved_upfront_fees
    remove_column :loans, :approved_fixed_rate
    remove_column :loans, :executed_nominal_amount_usd
    remove_column :loans, :executed_nominal_amount_local_currency
    remove_column :loans, :executed_tenor
    remove_column :loans, :executed_spread
    remove_column :loans, :executed_upfront_fees
    remove_column :loans, :executed_fixed_rate
    remove_column :loans, :pending_ratification_nominal_amount_usd
    remove_column :loans, :pending_ratification_nominal_amount_local_currency
    remove_column :loans, :pending_ratification_tenor
    remove_column :loans, :pending_ratification_spread
    remove_column :loans, :pending_ratification_upfront_fees
    remove_column :loans, :pending_ratification_fixed_rate
    remove_column :loans, :pending_ratification_date
    remove_column :loans, :deadline_pending_ratification_date
    remove_column :loans, :pending_approval_nominal_amount_usd
    remove_column :loans, :pending_approval_nominal_amount_local_currency
    remove_column :loans, :pending_approval_tenor
    remove_column :loans, :pending_approval_spread
    remove_column :loans, :pending_approval_upfront_fees
    remove_column :loans, :pending_approval_fixed_rate
    remove_column :loans, :pending_approval_date
    remove_column :loans, :deadline_pending_approval_date
    remove_column :loans, :approved_change_request_nominal_amount_usd
    remove_column :loans, :approved_change_request_nominal_amount_local_currency
    remove_column :loans, :approved_change_request_tenor
    remove_column :loans, :approved_change_request_spread
    remove_column :loans, :approved_change_request_upfront_fees
    remove_column :loans, :approved_change_request_fixed_rate
    remove_column :loans, :approval_change_request_date
    remove_column :loans, :deadline_approval_change_request_date
  end

  def down
    drop_table :loan_versions

    add_column :loans,  :status, :string, null: false
    add_column :loans,  :currency_id, :references, foreign_key: true
    add_column :loans,  :loan_type_id, :references, foreign_key: true
    add_column :loans,  :repayment_type_id, :references, foreign_key: true
    add_column :loans,  :assignment_date, :date
    add_column :loans,  :deadline_assignment_date, :date
    add_column :loans,  :ratification_date, :date
    add_column :loans,  :deadline_ratification_date, :date
    add_column :loans,  :approval_date, :date
    add_column :loans,  :deadline_approval_date, :date
    add_column :loans,  :expected_disbursement_date, :date
    add_column :loans,  :specific_approval_condition, :string
    add_column :loans,  :probabilities, :float
    add_column :loans,  :bond, :string
    add_column :loans,  :disbursement_date, :date
    add_column :loans,  :in_waiting_list, :boolean, default: false, null: false
    add_column :loans,  :maturity_date, :date
    add_column :loans,  :nav_usd, :float
    add_column :loans,  :net_position_value_as_of_today, :float
    add_column :loans,  :gross_position_value_as_of_today, :float
    add_column :loans,  :critical_cases, :string
    add_column :loans,  :provision_date, :date
    add_column :loans,  :provision_value_usd, :float
    add_column :loans,  :interest_rate_type, :string
    add_column :loans,  :vrr, :float
    add_column :loans,  :vrr_maturity_date, :date
    add_column :loans,  :proposed_nominal_amount_usd, :float
    add_column :loans,  :proposed_nominal_amount_local_currency, :float
    add_column :loans,  :proposed_tenor, :integer
    add_column :loans,  :proposed_spread, :float
    add_column :loans,  :proposed_upfront_fees, :float
    add_column :loans,  :proposed_fixed_rate, :float
    add_column :loans,  :ratified_nominal_amount_usd, :float
    add_column :loans,  :ratified_nominal_amount_local_currency, :float
    add_column :loans,  :ratified_tenor, :integer
    add_column :loans,  :ratified_spread, :float
    add_column :loans,  :ratified_upfront_fees, :float
    add_column :loans,  :ratified_fixed_rate, :float
    add_column :loans,  :approved_nominal_amount_usd, :float
    add_column :loans,  :approved_nominal_amount_local_currency, :float
    add_column :loans,  :approved_tenor, :integer
    add_column :loans,  :approved_spread, :float
    add_column :loans,  :approved_upfront_fees, :float
    add_column :loans,  :approved_fixed_rate, :float
    add_column :loans,  :executed_nominal_amount_usd, :float
    add_column :loans,  :executed_nominal_amount_local_currency, :float
    add_column :loans,  :executed_tenor, :integer
    add_column :loans,  :executed_spread, :float
    add_column :loans,  :executed_upfront_fees, :float
    add_column :loans,  :executed_fixed_rate, :float
    add_column :loans,  :pending_ratification_nominal_amount_usd, :float
    add_column :loans,  :pending_ratification_nominal_amount_local_currency, :float
    add_column :loans,  :pending_ratification_tenor, :integer
    add_column :loans,  :pending_ratification_spread, :float
    add_column :loans,  :pending_ratification_upfront_fees, :float
    add_column :loans,  :pending_ratification_fixed_rate, :float
    add_column :loans,  :pending_ratification_date, :date
    add_column :loans,  :deadline_pending_ratification_date, :date
    add_column :loans,  :pending_approval_nominal_amount_usd, :float
    add_column :loans,  :pending_approval_nominal_amount_local_currency, :float
    add_column :loans,  :pending_approval_tenor, :integer
    add_column :loans,  :pending_approval_spread, :float
    add_column :loans,  :pending_approval_upfront_fees, :float
    add_column :loans,  :pending_approval_fixed_rate, :float
    add_column :loans,  :pending_approval_date, :date
    add_column :loans,  :deadline_pending_approval_date, :date
    add_column :loans,  :approved_change_request_nominal_amount_usd, :float
    add_column :loans,  :approved_change_request_nominal_amount_local_currency, :float
    add_column :loans,  :approved_change_request_tenor, :integer
    add_column :loans,  :approved_change_request_spread, :float
    add_column :loans,  :approved_change_request_upfront_fees, :float
    add_column :loans,  :approved_change_request_fixed_rate, :float
    add_column :loans,  :approval_change_request_date, :date
    add_column :loans,  :deadline_approval_change_request_date, :date
  end
end
