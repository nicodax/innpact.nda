class AddApprovalChangeRequestDateToLoans < ActiveRecord::Migration[6.0]
  def change
    add_column :loans, :approval_change_request_date, :date
    add_column :loans, :deadline_approval_change_request_date, :date
  end
end
