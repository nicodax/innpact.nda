class FillAgencyInstitution < ActiveRecord::Migration[6.0]
  def up
    Rake::Task['fill_agency_institution:fill_legacy'].invoke
  end
end
