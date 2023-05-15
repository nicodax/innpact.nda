class RenameInstitutionImmEsgInInstitutionEsgSdgContribution < ActiveRecord::Migration[6.0]
  def up
    rename_table :institution_imm_esgs, :institution_esg_sdg_contributions
  end

  def down
    rename_table :institution_esg_sdg_contributions, :institution_imm_esgs
  end
end
