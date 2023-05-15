class CreateLimitExceptions < ActiveRecord::Migration[6.0]
  def change
    create_table :limit_exceptions do |t|
      t.string :model
      t.integer :model_id
      t.integer :value

      t.timestamps
    end
  end
end
