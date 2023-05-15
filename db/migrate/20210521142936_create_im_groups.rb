class CreateImGroups < ActiveRecord::Migration[6.0]
  def change
    create_table :im_groups do |t|
      t.string :name, null: false
      t.string :description
      t.references :fund, null: false

      t.timestamps
    end

    add_index :im_groups, %i[name fund_id], unique: true
  end
end
