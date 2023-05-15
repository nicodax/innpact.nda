class UpdateVAdditionalPaiSocialsToVersion3 < ActiveRecord::Migration[6.0]
  def change
    update_view :v_additional_pai_socials, version: 3, revert_to_version: 2
  end
end
