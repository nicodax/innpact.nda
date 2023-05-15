class UpdateVInstitutionsToVersion14 < ActiveRecord::Migration[6.0]
  def change
    update_view :v_institutions, version: 14, revert_to_version: 13
  end
end
