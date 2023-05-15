class AddPresentableAtToLoanVersion < ActiveRecord::Migration[6.0]
  def change
    add_column :loan_versions, :presentable_at, :datetime
  end
end
