class CreateInstitutionDistributionBySectors < ActiveRecord::Migration[6.0]
  def up
    create_table :institution_distribution_by_sectors do |t|
      t.references :institution, null: false
      t.references :user, foreign_key: true
      t.decimal :production, precision: 17, scale: 2
      t.decimal :agriculture, precision: 17, scale: 2
      t.decimal :consumption, precision: 17, scale: 2
      t.decimal :other, precision: 17, scale: 2
      t.decimal :trade_and_services, precision: 17, scale: 2
      t.datetime :deleted_at
      t.datetime :as_of, default: -> { 'CURRENT_TIMESTAMP' }
      t.timestamps
    end
  end
  def down
    drop_table :institution_distribution_by_sectors
  end
end
