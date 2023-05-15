class UpdateVAdditionalPaiEnvironmentsToVersion3 < ActiveRecord::Migration[6.0]
  def change
    update_view :v_additional_pai_environments, version: 3, revert_to_version: 2
  end
end
