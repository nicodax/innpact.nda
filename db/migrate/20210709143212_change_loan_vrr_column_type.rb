class ChangeLoanVrrColumnType < ActiveRecord::Migration[6.0]
  def up
    change_column :loan_versions, :vrr, :string
  end

  def down
    change_column :loan_versions, :vrr, :float
  end
end
