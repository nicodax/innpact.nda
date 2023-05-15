class RenameOldColumns < ActiveRecord::Migration[6.0]
  def change
    # # General
    # rename_column :institutions, :tier, :to_delete_tier
    # rename_column :institutions, :regulatory_status, :to_delete_regulatory_status
    # rename_column :institutions, :cpps_adoption, :to_delete_cpps_adoption
    # rename_column :institutions, :use_of_standard_reporting_tools, :to_delete_use_of_standard_reporting_tools
    # rename_column :institutions, :external_rating_agency, :to_delete_external_rating_agency
    # rename_column :institutions, :external_rating, :to_delete_external_rating
    # rename_column :institutions, :internal_rating, :to_delete_internal_rating
    # rename_column :institutions, :probability_of_default, :to_delete_probability_of_default
    # rename_column :institutions, :general_as_of_date, :to_delete_general_as_of_date
    # rename_column :institutions, :general_rating_as_of_date, :to_delete_general_rating_as_of_date

    # # Financial
    # rename_column :institutions, :total_assets, :to_delete_total_assets
    # rename_column :institutions, :gross_loan_portfolio, :to_delete_gross_loan_portfolio
    # rename_column :institutions, :provision_for_loss, :to_delete_provision_for_loss
    # rename_column :institutions, :international_liabilities, :to_delete_international_liabilities
    # rename_column :institutions, :domestic_liabilities, :to_delete_domestic_liabilities
    # rename_column :institutions, :deposit_amount, :to_delete_deposit_amount
    # rename_column :institutions, :liabilities, :to_delete_liabilities
    # rename_column :institutions, :equity, :to_delete_equity
    # rename_column :institutions, :revenues, :to_delete_revenues
    # rename_column :institutions, :net_income, :to_delete_net_income
    # rename_column :institutions, :net_income_distributed_as_dividends, :to_delete_net_income_distributed_as_dividends
    # rename_column :institutions, :npls, :to_delete_npls
    # rename_column :institutions, :write_off, :to_delete_write_off

    # # portfolio breakdown
    # rename_column :institutions, :microfinance_portfolio_size, :to_delete_microfinance_portfolio_size
    # rename_column :institutions, :sme_portfolio_size_under_35k, :to_delete_sme_portfolio_size_under_35k
    # rename_column :institutions, :sme_portfolio_size_under_50k, :to_delete_sme_portfolio_size_under_50k
    # rename_column :institutions, :percentage_rural_ptf, :to_delete_percentage_rural_ptf
    # rename_column :institutions, :trade_and_services, :to_delete_trade_and_service
    # rename_column :institutions, :agriculture, :to_delete_agriculture
    # rename_column :institutions, :production, :to_delete_production
    # rename_column :institutions, :consumption, :to_delete_consumption
    # rename_column :institutions, :other, :to_delete_other
    # rename_column :institutions, :microenterprise_usd, :to_delete_microenterprise_usd
    # rename_column :institutions, :sme_usd, :to_delete_sme_usd
    # rename_column :institutions, :corporate_usd, :to_delete_corporate_usd
    # rename_column :institutions, :housing_usd, :to_delete_housing_usd
    # rename_column :institutions, :personal_usd, :to_delete_personal_usd
    # rename_column :institutions, :other_usd, :to_delete_other_usd

    # # positive impact
    # rename_column :institutions, :internal_impact_score, :to_delete_internal_impact_score
    # rename_column :institutions, :avg_loan_size, :to_delete_avg_loan_size
    # rename_column :institutions, :number_of_clients, :to_delete_number_of_clients
    # rename_column :institutions, :borrowers_count, :to_delete_borrowers_count
    # rename_column :institutions, :female_borrowers_count, :to_delete_female_borrowers_count
    # rename_column :institutions, :rural_borrowers_count, :to_delete_rural_borrowers_count
    # rename_column :institutions, :number_of_sme_borrowers, :to_delete_number_of_sme_borrowers
    # rename_column :institutions, :number_of_micro_borrowers, :to_delete_number_of_micro_borrowers
    # rename_column :institutions, :mobile_banking_services, :to_delete_mobile_banking_services
    # rename_column :institutions, :number_clients_using_mobile_banking, :to_delete_number_clients_using_mobile_banking
    # rename_column :institutions, :deposits, :to_delete_deposits
    # rename_column :institutions, :number_clients_with_deposits, :to_delete_number_clients_with_deposits
    # rename_column :institutions, :voluntary_savings, :to_delete_voluntary_savings

    # rename_column :institutions, :percentage_of_women_ptf, :to_delete_percentage_of_women_ptf
    # rename_column :institutions, :overall_sptf_alinus_score, :to_delete_overall_sptf_alinus_score
    # rename_column :institutions, :define_and_monitor_social_goals, :to_delete_define_and_monitor_social_goals
    # rename_column :institutions, :ensure_commitment_to_social_goals, :to_delete_ensure_commitment_to_social_goals
    # rename_column :institutions, :product_design_to_meet_clients_need, :to_delete_product_design_to_meet_clients_need
    # rename_column :institutions, :treat_clients_responsibly, :to_delete_treat_clients_responsibly
    # rename_column :institutions, :treat_employees_responsibly, :to_delete_treat_employees_responsibly
    # rename_column :institutions, :balance_financial_and_performance, :to_delete_balance_financial_and_performance
    # rename_column :institutions, :promote_environmental_protection, :to_delete_promote_environmental_protection
  end
end
