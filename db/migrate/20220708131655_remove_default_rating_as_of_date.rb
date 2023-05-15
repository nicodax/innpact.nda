# frozen_string_literal: true

class RemoveDefaultRatingAsOfDate < ActiveRecord::Migration[6.0]
  def up
    add_column :institutions, :general_rating_as_of_date, :datetime
    add_column :archive_v_institutions, :general_rating_as_of_date, :datetime
    remove_column :institutions, :as_of_institution_general_rating, if_exists: true
    remove_column :archive_v_institutions, :as_of_institution_general_rating, if_exists: true
  end

  def down
    add_column :institutions, :as_of_institution_general_rating, :datetime, default: -> { 'CURRENT_TIMESTAMP' }
    add_column :archive_v_institutions, :as_of_institution_general_rating, :datetime, default: -> { 'CURRENT_TIMESTAMP' }
    remove_column :institutions, :general_rating_as_of_date, if_exists: true
    remove_column :archive_v_institutions, :general_rating_as_of_date, if_exists: true
  end
end
