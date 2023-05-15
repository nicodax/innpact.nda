class AddDefaultValueToLoanRequestWaitingList < ActiveRecord::Migration[6.0]
  def change
    change_column :loan_requests, :waiting_list, :boolean, null: false, default: true
  end
end
