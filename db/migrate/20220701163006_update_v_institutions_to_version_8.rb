class UpdateVInstitutionsToVersion8 < ActiveRecord::Migration[6.0]
  def change
    add_column :archive_v_institutions, :as_of_institution_general_rating, :datetime, default: -> { 'CURRENT_TIMESTAMP' }
    add_column :archive_v_institutions, :probability_of_default, :decimal
    add_column :archive_v_institutions, :sme_portfolio_size_under_50k, :decimal
    rename_column :archive_v_institutions, :sme_portfolio_size, :sme_portfolio_size_under_35k
    update_view :v_institutions, version: 8, revert_to_version: 7
  end
end
