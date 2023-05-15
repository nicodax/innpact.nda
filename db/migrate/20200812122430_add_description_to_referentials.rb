class AddDescriptionToReferentials < ActiveRecord::Migration[6.0]
  def change
    add_column :loan_types, :description, :string
    add_column :regions, :description, :string
  end
end
