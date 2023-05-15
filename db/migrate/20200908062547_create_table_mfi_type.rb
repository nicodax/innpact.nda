class CreateTableMfiType < ActiveRecord::Migration[6.0]
  def change
    create_table :mfi_types do |t|
      t.string :name
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
