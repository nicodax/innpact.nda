# frozen_string_literal: true

module Settings
  class InstitutionsController < SettingsController
    before_action :generate_institution, only: %i[import index new upload]
    before_action :set_setting, only: %i[import show edit update destroy upload]
    before_action :set_setting_collection, only: %i[import index new upload show edit]
    before_action :set_loans_provision_summary, only: %i[show]

    def index
      @new_setting = if current_user.investment_manager?
                       fund.instance_eval(resource_attribute_name)
                           .build(im_group: current_user.im_group_for_fund(fund: fund)).decorate
                     else
                       fund.instance_eval(resource_attribute_name).build.decorate
                     end
    end

    def new
      @new_setting = if current_user.investment_manager?
                       fund.instance_eval(resource_attribute_name)
                           .build(im_group: current_user.im_group_for_fund(fund: fund)).decorate
                     else
                       fund.instance_eval(resource_attribute_name).build.decorate
                     end
    end

    def create
      result = CreateInstitutionInteractor.call(institution_params: setting_params, setting: setting,
                                                file: params[:institution][:file], fund: fund)
      if result.success?
        redirect_to after_create_path,
                    notice: t('settings_crud.setting_success_creation', setting_name: resource_name)
      else
        set_setting_collection
        @new_setting = result.setting
        @covenant = new_setting.institution_covenant

        flash.now[:alert] =
          [t('settings_crud.setting_error_creation', setting_name: resource_name.downcase),
           result.error].compact.join(' : ')
        render after_create_fail_action
      end
    end

    def update
      result = UpdateInstitutionInteractor.call(institution_params: setting_params, institution: setting,
                                                file: params[:institution][:file])
      if result.success?
        redirect_to after_update_path,
                    notice: t('settings_crud.setting_success_update', setting_name: resource_name)
      else
        set_setting_collection
        flash.now[:alert] =
          [t('settings_crud.setting_error_update', setting_name: resource_name.downcase),
           result.error].compact.join(' : ')
        render after_update_fail_action
      end
    end

    private

    attr_reader :loans_provision_summary

    helper_method :loans_provision_summary

    def generate_institution
      @new_setting = resource_class.new
      @covenant = new_setting.institution_covenant
    end

    def set_setting
      @setting = resource_class.find(params[:id]).decorate
      authorize(setting)
    end

    def resource_class
      Institution
    end

    def after_update_fail_action
      :edit
    end

    def set_loans_provision_summary
      @loans_provision_summary = Institutions::LoansProvisionSummary.new.call(institution: setting)
    end

    def setting_params
      params.require(:institution).permit(
        :name, :im_group_id, :country_id, :institution_group_id, :institution_type_id,
        :tier, :cpps_adoption, :regulatory_status, :general_as_of_date,
        :use_of_standard_reporting_tools,
        :in_watchlist, :watchlist_reason, :watchlist_entry_date,
        # Institution Financials simplified form attributes
        :financials_as_of_date, :total_assets, :gross_loan_portfolio, :equity, :net_income, :liabilities,
        # Institution Specific breakdown simplified form attributes
        :portfolio_breakdown_i_as_of_date, :microfinance_portfolio_size, :sme_portfolio_size_under_35k,
        # Institution Impact Indicators simplified form attributes
        :clients_as_of_date, :borrowers_count, :female_borrowers_count, :avg_loan_size,
        # TODO : TO BE DELETED AFTER REFACTORING
        # :general_rating_as_of_date
        # :portfolio_3y_ago,
        # :rural_borrowers_count,
        # :consumer_loans_share, :agriculture_loans_share, :housing_loans_share, :education_loans_share, :trade_loans_share,
        # :debt, :deposits, :other_liabilities,
        # :internal_rating, :external_rating, :external_rating_agency,
        # :trade, # Could be deleted after refactoring
        # :agriculture,
        # :education, # Could be deleted after refactoring
        # :housing, # Could be deleted after refactoring
        # :consumption,
        # :other,
        # :ia_esg_rating,
        # :environmental_rating,
        # :kyc_check,
        # :involvement_in_responsible_finance_initiatives,
        # :training_on_responsible_finance_targeting_women,
        # :provision_of_financial_products_targeting_enterprise_set_up,
        # :domestic_liabilities,
        # :international_liabilities,
        # :revenues,
        # :net_income_distributed_as_dividends,
        # :provision_for_loss,
        # :npls,
        # :write_off,
        # :deposit_amount,
        # :saving_amount,
        # :list_dfi_lenders,
        # :financial_strength_of_shareholders,
        # :number_of_micro_borrowers,
        # :number_of_sme_borrowers,
        # :services, # Could be deleted after refactoring
        # :trade_and_services,
        # :production,
        # :microenterprise_usd,
        # :sme_usd,
        # :corporate_usd,
        # :housing_usd,
        # :personal_usd,
        # :other_usd,
        # :has_sptf_alinus_reporting_using_alinus,
        # :sptf_alinus_reporting_using_alinus,
        # :overall_sptf_alinus_score,
        # :define_and_monitor_social_goals,
        # :ensure_commitment_to_social_goals,
        # :product_design_to_meet_clients_need,
        # :treat_clients_responsibly,
        # :treat_employees_responsibly,
        # :balance_financial_and_performance,
        # :promote_environmental_protection,
        # :portfolio_breakdown_ii_as_of_date,
        # :portfolio_breakdown_iii_as_of_date,
        # :aptf_alinus_results_as_of_date,
        # :services_offered_as_of_date,
        # :internal_impact_score,
        # :internal_credit_risk_rating,
        # :number_of_clients,
        # :probability_of_default,
        # :sme_portfolio_size_under_50k,
        # :percentage_rural_ptf, :percentage_of_women_ptf,
        # :voluntary_savings, :number_clients_using_mobile_banking, :number_clients_with_deposits,
        institution_covenants_attributes: %i[name par30 par30_limit par30_refy par30_refy_limit roa
                                             roa_limit adj_roa adj_roa_limit open_fx_exposure open_fx_exposure_limit
                                             open_loan_position open_loan_position_limit car car_limit
                                             deposits_liabilities deposits_liabilities_limit
                                             maturity_matching_if_applicable_limit liquid_assets_deposits_if_applicable
                                             liquid_assets_deposits_if_applicable_limit maturity_matching_if_applicable]
      )
    end
  end
end
