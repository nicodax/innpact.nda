class MovePoolIdFromLoansToLoanVersions < ActiveRecord::Migration[6.0]
  def change
    add_reference :loan_versions, :pool
    remove_column :loans, :pool_id
  end
end
