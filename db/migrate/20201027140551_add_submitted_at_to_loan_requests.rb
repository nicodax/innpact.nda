class AddSubmittedAtToLoanRequests < ActiveRecord::Migration[6.0]
  def change
    remove_column :loan_requests, :submitted, :boolean
    add_column :loan_requests, :submitted_at, :datetime
  end
end
