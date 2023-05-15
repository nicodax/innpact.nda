class AddColumnsToInstitutions < ActiveRecord::Migration[6.0]
  def change
    add_column :institutions, :trade, :decimal, precision: 17, scale: 2
    add_column :institutions, :agriculture, :decimal, precision: 17, scale: 2
    add_column :institutions, :education, :decimal, precision: 17, scale: 2
    add_column :institutions, :housing, :decimal, precision: 17, scale: 2
    add_column :institutions, :consumption, :decimal, precision: 17, scale: 2
    add_column :institutions, :other, :decimal, precision: 17, scale: 2
  end
end
