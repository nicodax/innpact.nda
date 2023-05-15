class AddAsOfDateForServicesOffered < ActiveRecord::Migration[6.0]
  def change
    add_column :institutions, :services_offered_as_of_date, :date
  end
end
