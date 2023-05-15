class CreateVAdditionalPaiSocials < ActiveRecord::Migration[6.0]
  def change
    create_view :v_additional_pai_socials

    create_table :archive_v_additional_pai_socials do |t|
      t.string :institution_id
      t.string :institution_name
      t.datetime :pais_social_as_of
      t.string :social_pai_reported
      t.decimal :social_pai_value, precision: 18, scale: 2
      t.datetime :data_viewed_at
    
      t.timestamps
    end
  end
end
