class UpdateVInstitutionsCovenantsToVersion3 < ActiveRecord::Migration[6.0]
  def change
    update_view :v_institutions_covenants, version: 3, revert_to_version: 2
  end
end
