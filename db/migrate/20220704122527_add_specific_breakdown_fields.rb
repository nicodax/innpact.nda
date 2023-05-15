class AddSpecificBreakdownFields < ActiveRecord::Migration[6.0]
  def change
    add_column :institutions, :percentage_rural_ptf, :decimal, precision: 5, scale: 2
    add_column :institutions, :percentage_of_women_ptf, :decimal, precision: 5, scale: 2
  end
end
