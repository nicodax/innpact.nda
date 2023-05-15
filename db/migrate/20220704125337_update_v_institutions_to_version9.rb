class UpdateVInstitutionsToVersion9 < ActiveRecord::Migration[6.0]
  def change
    update_view :v_institutions, version: 9, revert_to_version: 8
  end
end
