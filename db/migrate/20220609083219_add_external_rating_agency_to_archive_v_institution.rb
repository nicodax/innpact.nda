class AddExternalRatingAgencyToArchiveVInstitution < ActiveRecord::Migration[6.0]
  def change
    add_column :archive_v_institutions, :external_rating_agency, :string
    rename_column :archive_v_institutions, :external_rating_moody, :external_rating
  end
end
