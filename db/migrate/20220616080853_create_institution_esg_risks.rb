class CreateInstitutionEsgRisks < ActiveRecord::Migration[6.0]
  def up
    create_table :institution_esg_risks do |t|
      t.references :institution, null: false
      t.string :internal_esg_score, null: false, limit: 10
      t.string :ifc_esg_risk_financial_intermediaries_classification, null: false
      t.boolean :esms_in_place_commensurate_with_risk_profile, null: false, default: false
      t.datetime :deleted_at
      t.datetime :as_of, default: DateTime.now, null: false

      t.timestamps
    end
  end
  def down
    drop_table :institution_esg_risks
  end
end
