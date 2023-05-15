class AAddNavDateToLoanVersions < ActiveRecord::Migration[6.0]
  def change
    add_column :loan_versions, :nav_date, :date
  end
end
