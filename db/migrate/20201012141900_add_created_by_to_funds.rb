class AddCreatedByToFunds < ActiveRecord::Migration[6.0]
  def up
    add_column :funds, :created_by, :string
    change_column :funds, :created_by, :string, null: false
    remove_column :funds, :user_id
  end

  def down
    remove_column :funds, :created_by
    add_reference :funds, :user, index: true
  end
end
