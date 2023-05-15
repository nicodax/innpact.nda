class AddTrancheForLoan < ActiveRecord::Migration[6.0]
  def change
    add_column :loans, :original_loan_id, :bigint
    add_column :loans, :copied_at, :datetime
  end
end
