class CreateMfiGroups < ActiveRecord::Migration[6.0]
  def change
    create_table :mfi_groups do |t|
      t.string :name
      t.belongs_to :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
