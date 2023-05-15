class UpdateVInstitutionsToVersion12 < ActiveRecord::Migration[6.0]
  def change
    update_view :v_institutions, version: 12, revert_to_version: 11
  end
end
