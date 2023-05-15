class CreateBonds < ActiveRecord::Migration[6.0]
  def up
    create_table :bonds do |t|
      t.string :name
      t.string :description
      t.datetime :deleted_at

      t.timestamps
    end

    remove_column :loan_versions, :bond, :string
    add_reference :loan_versions, :bond
  end

  def down
    remove_column :loan_versions, :bond_id, :integer
    add_column :loan_versions, :bond, :string

    drop_table :bonds
  end
end
