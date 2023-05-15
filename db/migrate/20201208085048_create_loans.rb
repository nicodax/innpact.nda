class CreateLoans < ActiveRecord::Migration[6.0]
  def change
    create_table :loans do |t|
      t.references :fund, null: false, foreign_key: true
      t.references :investment_manager, index: true, foreign_key: { to_table: :users }
      t.references :pool, null: false, foreign_key: true
      t.integer :innpact_loan_id, null: false
      t.references :institution, foreign_key: true
      t.string :status, null: false
      t.references :currency, foreign_key: true
      t.references :loan_type, foreign_key: true
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
      t.date :assignment_date
      t.date :deadline_assignment_date
      t.date :ratification_date
      t.date :deadline_ratification_date
      t.date :approval_date
      t.date :deadline_approval_date
      t.date :expected_disbursement_date
      t.string :specific_approval_condition
      t.float :probabilities
      t.references :repayment_type, foreign_key: true

      t.references :creation_user, null: false, foreign_key: { to_table: :users }
      t.date :deleted_at
      t.timestamps
    end

    add_index :loans, :innpact_loan_id, unique: true
    add_index :loans, :status
  end
end
