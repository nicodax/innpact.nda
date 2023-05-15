class AddRestructuringInLoans < ActiveRecord::Migration[6.0]
  def change
    add_column :loans, :restructuring, :boolean, null: false, default: false
  end
end
