class AddUpdatedByToInstitutionEsg < ActiveRecord::Migration[6.0]
  def up
    add_reference :institution_imm_esgs, :user, foreign_key: true
    add_reference :institution_esg_gender_equalities, :user, foreign_key: true
    add_reference :institution_esg_safeguards, :user, foreign_key: true
    add_reference :institution_esg_risks, :user, foreign_key: true
    add_reference :institution_esg_pai_indicators, :user, foreign_key: true
  end
  def down
    remove_reference :institution_imm_esgs, :user, foreign_key: true
    remove_reference :institution_esg_gender_equalities, :user, foreign_key: true
    remove_reference :institution_esg_safeguards, :user, foreign_key: true
    remove_reference :institution_esg_risks, :user, foreign_key: true
    remove_reference :institution_esg_pai_indicators, :user, foreign_key: true
  end
end
