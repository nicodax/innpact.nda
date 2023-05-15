class CreateInstitutionEsgSafeguards < ActiveRecord::Migration[6.0]
  def up
    create_table :institution_esg_safeguards do |t|
      t.references :institution, null: false
      t.boolean :compliance_with_fund_exclusion_list, null: false, default: false
      t.boolean :compliance_with_international_labour_organization_standards, null: false, default: false
      t.boolean :compliance_with_international_bill_of_human_rights, null: false, default: false
      t.boolean :compliance_with_guiding_principles_on_business_and_human_rights, null: false, default: false
      t.boolean :compliance_with_oecd_guidelines_for_multinational_enterprises, null: false, default: false
      t.boolean :compliance_with_national_standards_and_law, null: false, default: false
      t.boolean :compliance_with_client_protection_principles, null: false, default: false
      t.datetime :deleted_at
      t.datetime :as_of, default: DateTime.now
      
      t.timestamps
    end
  end
  def down
    drop_table :institution_esg_safeguards
  end
end

