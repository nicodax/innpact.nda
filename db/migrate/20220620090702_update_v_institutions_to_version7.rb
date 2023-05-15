class UpdateVInstitutionsToVersion7 < ActiveRecord::Migration[6.0]
  def change
    update_view :v_institutions, version: 7, revert_to_version: 6
  end
end
