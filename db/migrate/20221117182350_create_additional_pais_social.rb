class CreateAdditionalPaisSocial < ActiveRecord::Migration[6.0]
  def up
    create_table :additional_pais_socials do |t|
      t.references :institution, null: false
      t.references :user, foreign_key: true
      t.string :environment_pai_reported
      t.decimal :environment_pai_value, precision: 18, scale: 2
      t.datetime :deleted_at
      t.datetime :as_of, default: -> { 'CURRENT_TIMESTAMP' }
      t.timestamps
    end
  end
  def down
    drop_table :additional_pais_socials
  end
end
