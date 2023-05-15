class CreateInterestRateTypes < ActiveRecord::Migration[6.0]
  def up
    create_table :interest_rate_types do |t|
      t.string :name, null: false
      t.string :description, null: false
      t.datetime :deleted_at

      t.timestamps
    end

    remove_column :loan_versions, :interest_rate_type, :string
    add_reference :loan_versions, :interest_rate_type
  end

  def down
    remove_column :loan_versions, :interest_rate_type_id, :integer
    add_column :loan_versions, :interest_rate_type, :string

    drop_table :interest_rate_types
  end
end
