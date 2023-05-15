class CreateCountNumberOfRowsInArchiveViews < ActiveRecord::Migration[6.0]
  def change
    create_view :count_number_of_rows_in_archive_views
  end
end
