class AddBondToLoans < ActiveRecord::Migration[6.0]
  def change
    add_column :loans, :bond, :string
  end
end
