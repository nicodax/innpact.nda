class AddImGroupToLoans < ActiveRecord::Migration[6.0]
  def change
    add_column :loans, :im_group_id, :bigint
    add_index :loans, :im_group_id
  end
end
