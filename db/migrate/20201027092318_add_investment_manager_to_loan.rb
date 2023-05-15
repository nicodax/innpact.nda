class AddInvestmentManagerToLoan < ActiveRecord::Migration[6.0]
  def change
    add_column :loan_requests, :assigned_investment_manager_id, :bigint
    add_foreign_key :loan_requests, :users, column: :assigned_investment_manager_id
  end
end
