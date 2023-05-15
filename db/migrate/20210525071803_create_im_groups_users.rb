class CreateImGroupsUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :im_groups_users, id: false do |t|
      t.bigint :im_group_id, index: true
      t.bigint :user_id, index: true
    end
  end
end
