namespace :fill_agency_institution do
  desc %q(The data for the old institution should have external_rating_agency set to "Moody's" if they have an external_rating.
    Legacy version used in the migration)
  task fill_legacy: :environment do
    # rubocop:disable Rails/SkipsModelValidations
    Institution.where.not(external_rating: "").where(external_rating_agency: nil).update_all(external_rating_agency: "Moody's")
    # rubocop:enable Rails/SkipsModelValidations
  end

  desc %q(The data for the old institution should have external_rating_agency set to "Moody's" if they have an external_rating)
  task fill: :environment do
    # rubocop:disable Rails/SkipsModelValidations
    InstitutionRating.where.not(external_rating: "").where(external_rating_agency: nil).update_all(external_rating_agency: "Moody's")
    # rubocop:enable Rails/SkipsModelValidations
  end
end
