class AddExternalRatingAgencyToInstitution < ActiveRecord::Migration[6.0]
  def change
    add_column :institutions, :external_rating_agency, :string
  end
end
