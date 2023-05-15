class AddPropertiesToInstitutions < ActiveRecord::Migration[6.0]
  def change
    add_column :institutions, :ia_esg_rating, :integer
    add_column :institutions, :environmental_rating, :boolean
    add_column :institutions, :cpps_adoption, :string
    add_column :institutions, :kyc_check, :string
    add_column :institutions, :use_of_standard_reporting_tools, :boolean
    add_column :institutions, :involvement_in_responsible_finance_initiatives, :boolean
    add_column :institutions, :training_on_responsible_finance_targeting_women, :boolean
    add_column :institutions, :provision_of_financial_products_targeting_enterprise_set_up, :boolean
    add_column :institutions, :liabilities, :decimal, precision: 17, scale: 2
    add_column :institutions, :domestic_liabilities, :decimal, precision: 17, scale: 2
    add_column :institutions, :international_liabilities, :decimal, precision: 17, scale: 2
    add_column :institutions, :calendar_liabilities_and_assets, :string
    add_column :institutions, :revenues, :decimal, precision: 17, scale: 2
    add_column :institutions, :net_income_distributed_as_dividends, :decimal, precision: 17, scale: 2
    add_column :institutions, :provision_for_loss, :decimal, precision: 17, scale: 2
    add_column :institutions, :write_off, :decimal, precision: 17, scale: 2
    add_column :institutions, :deposit_amount, :decimal, precision: 17, scale: 2
    add_column :institutions, :saving, :boolean
    add_column :institutions, :saving_amount, :decimal, precision: 17, scale: 2
    add_column :institutions, :mobile_banking_services, :boolean
    add_column :institutions, :list_dfi_lenders, :string
    add_column :institutions, :financial_strength_of_shareholders, :string, limit: 50
    add_column :institutions, :number_of_micro_borrowers, :integer
    add_column :institutions, :number_of_sme_borrowers, :integer
    add_column :institutions, :services, :decimal, precision: 17, scale: 2
    add_column :institutions, :production, :decimal, precision: 17, scale: 2
    add_column :institutions, :microenterprise_usd, :decimal, precision: 17, scale: 2
    add_column :institutions, :sme_usd, :decimal, precision: 17, scale: 2
    add_column :institutions, :corporate_usd, :decimal, precision: 17, scale: 2
    add_column :institutions, :housing_usd, :decimal, precision: 17, scale: 2
    add_column :institutions, :personal_usd, :decimal, precision: 17, scale: 2
    add_column :institutions, :other_usd, :decimal, precision: 17, scale: 2
    add_column :institutions, :has_sptf_alinus_reporting_using_alinus, :boolean
    add_column :institutions, :sptf_alinus_reporting_using_alinus, :string, limit: 15
    add_column :institutions, :overall_sptf_alinus_score, :decimal, precision: 5, scale: 2
    add_column :institutions, :define_and_monitor_social_goals, :decimal, precision: 5, scale: 2
    add_column :institutions, :ensure_commitment_to_social_goals, :decimal, precision: 5, scale: 2
    add_column :institutions, :product_design_to_meet_clients_need, :decimal, precision: 5, scale: 2
    add_column :institutions, :treat_clients_responsibly, :decimal, precision: 5, scale: 2
    add_column :institutions, :treat_employees_responsibly, :decimal, precision: 5, scale: 2
    add_column :institutions, :balance_financial_and_performance, :decimal, precision: 5, scale: 2
    add_column :institutions, :promote_environmental_protection, :decimal, precision: 5, scale: 2
    def up
      change_column :institutions, :deposits, :boolean
    end

    def down
      change_column :institutions, :deposits, :integer
    end
  end
end
