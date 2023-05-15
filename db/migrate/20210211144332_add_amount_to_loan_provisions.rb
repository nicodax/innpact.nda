class AddAmountToLoanProvisions < ActiveRecord::Migration[6.0]
  def change
    add_column :loan_provisions, :amount, :float
    change_column :loan_provisions, :percentage, :float, null: true
  end
end
