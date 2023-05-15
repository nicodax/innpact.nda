class AddHedgeToLoanVersion < ActiveRecord::Migration[6.0]
  def change
    add_column :loan_versions, :invested_hedge, :string, limit: 100
  end
end
