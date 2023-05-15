class AddLoanVersionIdToArchiveVLoans < ActiveRecord::Migration[6.0]
  def change
    add_column :archive_v_loans, :loan_version_id, :bigint
  end
end
