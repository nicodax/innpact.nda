class AddImGroupToInstitutions < ActiveRecord::Migration[6.0]
  def change
    add_column :institutions, :im_group_id, :bigint
    add_index :institutions, :im_group_id
  end
end
