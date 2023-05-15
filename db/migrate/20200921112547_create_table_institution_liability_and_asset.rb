class CreateTableInstitutionLiabilityAndAsset < ActiveRecord::Migration[6.0]
  def change
    create_table :institution_liabilities do |t|
      t.decimal :amount, precision: 17, scale: 2
      t.datetime :date
      t.references :institution, foreign_key: true, null: false
      t.datetime :deleted_at

      t.timestamps
    end
    create_table :institution_assets do |t|
      t.decimal :amount, precision: 17, scale: 2
      t.datetime :date
      t.references :institution, foreign_key: true, null: false
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
