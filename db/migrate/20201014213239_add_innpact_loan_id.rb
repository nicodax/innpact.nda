class AddInnpactLoanId < ActiveRecord::Migration[6.0]
  def up
    execute 'CREATE SEQUENCE innpact_loan_id AS int START WITH 0'
    add_column :loan_requests, :innpact_loan_id, :integer, null: false, default: -> { 'NEXT VALUE FOR innpact_loan_id' }
    add_index :loan_requests, :innpact_loan_id, unique: true
  end

  def down
    remove_column :loan_requests, :innpact_loan_id
    execute 'DROP SEQUENCE innpact_loan_id'
  end
end
