class CreateDefaultLimits < ActiveRecord::Migration[6.0]
  def change
    create_table :default_limits do |t|
      t.string :model
      t.integer :value

      t.timestamps
    end
  end
end
