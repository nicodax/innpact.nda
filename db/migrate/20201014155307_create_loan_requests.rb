class CreateLoanRequests < ActiveRecord::Migration[6.0]
  def change
    create_table :loan_requests do |t|
      t.references :fund, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.references :institution, foreign_key: true
      t.float :spread
      t.float :upfront_fees
      t.float :fixed_rate
      t.integer :nominal_amount_usd
      t.integer :nominal_amount_local_currency
      t.references :currency, foreign_key: true
      t.integer :tenor
      t.float :execution_probability
      t.references :repayment_type, foreign_key: true
      t.string :mfi_pays
      t.integer :interest_payment_frequency
      t.references :loan_type, foreign_key: true
      t.integer :tranche
      t.string :intermediary
      t.float :syndication_amount
      t.string :hedge_structure
      t.date :assignement_date
      t.date :expected_dibursement_date
      t.boolean :sme_window, default: false, null: false
      t.boolean :submitted, default: false, null: false
      t.boolean :approved, default: false, null: false
      t.boolean :waiting_list, default: true, null: false

      t.timestamps
    end
  end
end
