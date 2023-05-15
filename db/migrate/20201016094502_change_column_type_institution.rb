class ChangeColumnTypeInstitution < ActiveRecord::Migration[6.0]
  def change
    remove_column :institutions, :m_borrowers_count, :integer
    remove_column :institutions, :agriculture_loans_share, :integer
    remove_column :institutions, :consumer_loans_share, :integer
    remove_column :institutions, :education_loans_share, :integer
    remove_column :institutions, :trade_loans_share, :integer
    remove_column :institutions, :total_assets, :string
    remove_column :institutions, :gross_loan_portfolio, :string
    remove_column :institutions, :portfolio_3y_ago, :string
    remove_column :institutions, :equity, :string
    remove_column :institutions, :debt, :string
    remove_column :institutions, :other_liabilities, :string
    remove_column :institutions, :net_income, :string
    remove_column :institutions, :avg_loan_size, :integer
    remove_column :institutions, :deposits, :integer
    remove_column :institutions, :housing_loans_share, :integer
    add_column :institutions, :total_assets, :decimal, precision: 17, scale: 2
    add_column :institutions, :gross_loan_portfolio, :decimal, precision: 17, scale: 2
    add_column :institutions, :portfolio_3y_ago, :decimal, precision: 17, scale: 2
    add_column :institutions, :equity, :decimal, precision: 17, scale: 2
    add_column :institutions, :other_liabilities, :decimal, precision: 17, scale: 2
    add_column :institutions, :net_income, :decimal, precision: 17, scale: 2
    add_column :institutions, :avg_loan_size, :decimal, precision: 17, scale: 2
    add_column :institutions, :deposits, :boolean
    change_column :institutions, :borrowers_count, :bigint
    change_column :institutions, :female_borrowers_count, :bigint
    change_column :institutions, :rural_borrowers_count, :bigint
    change_column :institutions, :microfinance_portfolio_size, :decimal, precision: 17, scale: 2
    change_column :institutions, :sme_portfolio_size, :decimal, precision: 17, scale: 2
    change_column :institutions, :number_of_micro_borrowers, :bigint
    change_column :institutions, :number_of_sme_borrowers, :bigint
  end
end
