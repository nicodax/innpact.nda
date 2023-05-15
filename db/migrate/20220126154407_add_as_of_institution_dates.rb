class AddAsOfInstitutionDates < ActiveRecord::Migration[6.0]
  def change
    add_column :institutions, :general_as_of_date, :date
    add_column :institutions, :financials_as_of_date, :date
    add_column :institutions, :clients_as_of_date, :date
    add_column :institutions, :portfolio_breakdown_i_as_of_date, :date
    add_column :institutions, :portfolio_breakdown_ii_as_of_date, :date
    add_column :institutions, :portfolio_breakdown_iii_as_of_date, :date
    add_column :institutions, :aptf_alinus_results_as_of_date, :date
  end
end
