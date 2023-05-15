class AddNplsToInstitution < ActiveRecord::Migration[6.0]
  def change
    add_column :institutions, :npls, :decimal, precision: 5, scale: 2
  end
end
