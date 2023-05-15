class RenameAdditionalPaisSocialsColumns < ActiveRecord::Migration[6.0]
  def change
    rename_column :additional_pais_socials, :environment_pai_reported, :social_pai_reported
    rename_column :additional_pais_socials, :environment_pai_value, :social_pai_value
  end
end
