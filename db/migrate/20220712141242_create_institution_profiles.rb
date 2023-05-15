class CreateInstitutionProfiles < ActiveRecord::Migration[6.0]
  def up
    create_table :institution_profiles do |t|
      t.references :institution, null: false
      t.references :user, foreign_key: true
      t.integer :tier
      t.string :cpps_adoption
      t.boolean :use_of_standard_reporting_tools
      t.string :regulatory_status
      t.datetime :deleted_at
      t.datetime :as_of, default: -> { 'CURRENT_TIMESTAMP' }
      t.timestamps
    end
  end
  def down
    drop_table :institution_profiles
  end
end
