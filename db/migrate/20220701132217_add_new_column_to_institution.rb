class AddNewColumnToInstitution < ActiveRecord::Migration[6.0]
  def up
    add_column :institutions, :as_of_institution_general_rating, :datetime, default: -> { 'CURRENT_TIMESTAMP' }
    add_column :institutions, :probability_of_default, :decimal
    add_column :institutions, :sme_portfolio_size_under_50k, :decimal
    rename_column :institutions, :sme_portfolio_size, :sme_portfolio_size_under_35k
  end
  def down
    remove_column :institutions, :as_of_institution_general_rating
    remove_column :institutions, :probability_of_default
    remove_column :institutions, :sme_portfolio_size_under_50k
    rename_column :institutions, :sme_portfolio_size_under_35k, :sme_portfolio_size
  end
end
