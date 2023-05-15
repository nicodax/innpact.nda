class UpdateLoanDisbursementDate < ActiveRecord::Migration[6.0]
  def change
    remove_column :loans, :disbursement_date
    add_column :loans, :disbursement_date, :date
  end
end
