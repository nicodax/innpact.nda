class RemoveCreationUserReference < ActiveRecord::Migration[6.0]
  def up
    add_column :institution_groups, :created_by, :string
    change_column :institution_groups, :created_by, :string, null: false
    remove_column :institution_groups, :user_id

    add_column :countries, :created_by, :string
    change_column :countries, :created_by, :string, null: false
    remove_column :countries, :user_id

    add_column :currency_rates, :created_by, :string
    change_column :currency_rates, :created_by, :string, null: false
    remove_column :currency_rates, :user_id
  end

  def down
    remove_column :institution_groups, :created_by
    add_reference :institution_groups, :user, index: true

    remove_column :countries, :created_by
    add_reference :countries, :user, index: true

    remove_column :currency_rates, :created_by
    add_reference :currency_rates, :user, index: true
  end
end
