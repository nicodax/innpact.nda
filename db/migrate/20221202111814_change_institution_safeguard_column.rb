class ChangeInstitutionSafeguardColumn < ActiveRecord::Migration[6.0]
  def change
    change_column :institution_esg_safeguards, :compliance_with_oecd_guidelines_for_multinational_enterprises, :string, null: true
  end
end
