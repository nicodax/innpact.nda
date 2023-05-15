class AddIndexOnLoanVersion < ActiveRecord::Migration[6.0]
  def change
    add_index :loan_versions, %i[loan_id version_number], unique: true
  end
end
