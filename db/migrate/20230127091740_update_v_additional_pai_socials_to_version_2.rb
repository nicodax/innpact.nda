class UpdateVAdditionalPaiSocialsToVersion2 < ActiveRecord::Migration[6.0]
  def change
    update_view :v_additional_pai_socials, version: 2, revert_to_version: 1
  end
end
