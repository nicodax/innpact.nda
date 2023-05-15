class AddInWaitingListToLoans < ActiveRecord::Migration[6.0]
  def change
    add_column :loans, :in_waiting_list, :boolean, null: false, default: false
  end
end
