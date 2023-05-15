class ChangeInstitutionsPrecisions < ActiveRecord::Migration[6.0]
  def up
    change_column :institutions, :total_assets, :decimal, precision: 18, scale: 2
    change_column :institutions, :equity, :decimal, precision: 18, scale: 2
    change_column :institutions, :liabilities, :decimal, precision: 18, scale: 2
    change_column :institutions, :domestic_liabilities, :decimal, precision: 18, scale: 2
    change_column :institutions, :international_liabilities, :decimal, precision: 18, scale: 2
    change_column :institutions, :other_liabilities, :decimal, precision: 18, scale: 2
    change_column :institutions, :revenues, :decimal, precision: 18, scale: 2
    change_column :institutions, :provision_for_loss, :decimal, precision: 18, scale: 2
    change_column :institutions, :net_income, :decimal, precision: 18, scale: 2
    change_column :institutions, :write_off, :decimal, precision: 18, scale: 2
    change_column :institutions, :deposit_amount, :decimal, precision: 18, scale: 2
    change_column :institutions, :saving_amount, :decimal, precision: 18, scale: 2
    change_column :institutions, :avg_loan_size, :decimal, precision: 18, scale: 2
    change_column :institutions, :gross_loan_portfolio, :decimal, precision: 18, scale: 2
    change_column :institutions, :portfolio_3y_ago, :decimal, precision: 18, scale: 2
    change_column :institutions, :microfinance_portfolio_size, :decimal, precision: 18, scale: 2
    change_column :institutions, :sme_portfolio_size, :decimal, precision: 18, scale: 2
    change_column :institutions, :microenterprise_usd, :decimal, precision: 18, scale: 2
    change_column :institutions, :sme_usd, :decimal, precision: 18, scale: 2
    change_column :institutions, :corporate_usd, :decimal, precision: 18, scale: 2
    change_column :institutions, :housing_usd, :decimal, precision: 18, scale: 2
    change_column :institutions, :personal_usd, :decimal, precision: 18, scale: 2
    change_column :institutions, :other_usd, :decimal, precision: 18, scale: 2
  end
  def down
    change_column :institutions, :total_assets, :decimal, precision: 17, scale: 2
    change_column :institutions, :equity, :decimal, precision: 17, scale: 2
    change_column :institutions, :liabilities, :decimal, precision: 17, scale: 2
    change_column :institutions, :domestic_liabilities, :decimal, precision: 17, scale: 2
    change_column :institutions, :international_liabilities, :decimal, precision: 17, scale: 2
    change_column :institutions, :other_liabilities, :decimal, precision: 17, scale: 2
    change_column :institutions, :revenues, :decimal, precision: 17, scale: 2
    change_column :institutions, :provision_for_loss, :decimal, precision: 17, scale: 2
    change_column :institutions, :net_income, :decimal, precision: 17, scale: 2
    change_column :institutions, :write_off, :decimal, precision: 17, scale: 2
    change_column :institutions, :deposit_amount, :decimal, precision: 17, scale: 2
    change_column :institutions, :saving_amount, :decimal, precision: 17, scale: 2
    change_column :institutions, :avg_loan_size, :decimal, precision: 17, scale: 2
    change_column :institutions, :gross_loan_portfolio, :decimal, precision: 17, scale: 2
    change_column :institutions, :portfolio_3y_ago, :decimal, precision: 17, scale: 2
    change_column :institutions, :microfinance_portfolio_size, :decimal, precision: 17, scale: 2
    change_column :institutions, :sme_portfolio_size, :decimal, precision: 17, scale: 2
    change_column :institutions, :microenterprise_usd, :decimal, precision: 17, scale: 2
    change_column :institutions, :sme_usd, :decimal, precision: 17, scale: 2
    change_column :institutions, :corporate_usd, :decimal, precision: 17, scale: 2
    change_column :institutions, :housing_usd, :decimal, precision: 17, scale: 2
    change_column :institutions, :personal_usd, :decimal, precision: 17, scale: 2
    change_column :institutions, :other_usd, :decimal, precision: 17, scale: 2
  end
end
