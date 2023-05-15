class CreateRestrictionsTables < ActiveRecord::Migration[6.0]
  def change
    create_table :pool_regions do |t|
      t.references :pool, foreign_key: true, null: false
      t.references :region, foreign_key: true, null: false
      t.datetime :deleted_at

      t.timestamps
    end

    create_table :pool_mfi_groups do |t|
      t.references :pool, foreign_key: true, null: false
      t.references :mfi_group, foreign_key: true, null: false
      t.datetime :deleted_at

      t.timestamps
    end
    create_table :pool_currencies do |t|
      t.references :pool, foreign_key: true, null: false
      t.references :currency, foreign_key: true, null: false
      t.datetime :deleted_at

      t.timestamps
    end
    create_table :pool_loan_types do |t|
      t.references :pool, foreign_key: true, null: false
      t.references :loan_type, foreign_key: true, null: false
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
