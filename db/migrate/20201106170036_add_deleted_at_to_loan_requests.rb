class AddDeletedAtToLoanRequests < ActiveRecord::Migration[6.0]
  def change
    add_column :loan_requests, :deleted_at, :datetime
  end
end
