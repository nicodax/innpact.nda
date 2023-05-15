class ChangeNameOfFBorrowersCountInInstitution < ActiveRecord::Migration[6.0]
  def change
    rename_column :institutions, :f_borrowers_count, :female_borrowers_count
    rename_column :institutions, :mf_portfolio_size, :microfinance_portfolio_size
  end
end
