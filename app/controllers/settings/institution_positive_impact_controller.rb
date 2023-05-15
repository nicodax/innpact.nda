# frozen_string_literal: true

module Settings
  class InstitutionPositiveImpactController < ApplicationController
    include FundScoped
    before_action :load_models

    def edit; end

    def update_alinus_result
      alinus_result = @institution.institution_alinus_results.order(as_of: :desc, updated_at: :desc).first

      new_alinus_result = @institution.institution_alinus_results.build(alinus_result_params)
      new_alinus_result[:user_id] = current_user.id

      if Institution.is_current_as_of_more_recent?(alinus_result.try(:as_of), alinus_result_params[:as_of])
        flash.now[:alert] = "Current ALINUS results data is more recent than the currently provided"
        @institution_alinus_result = new_alinus_result
        render :edit
      elsif new_alinus_result.save
        redirect_to fund_settings_institution_path(fund_id: @institution.fund.id,
                                                   id: @institution.id,
                                                   selected_tab: 'impact_and_esg',
                                                   anchor: 'positive_impact_tab')
      else
        flash.now[:alert] = new_alinus_result.errors.full_messages
        @institution_alinus_result = new_alinus_result
        render :edit
      end
    end

    def update_gender_equality
      gender_equality = @institution.institution_esg_gender_equalities.order(as_of: :desc, updated_at: :desc).first

      new_gender_equality = @institution.institution_esg_gender_equalities.build(gender_equality_params)
      new_gender_equality[:user_id] = current_user.id

      if Institution.is_current_as_of_more_recent?(gender_equality.try(:as_of), gender_equality_params[:as_of])
        flash.now[:alert] = "Current Institution gender equality data is more recent than the currently provided"
        @institution_gender_equality = new_gender_equality
        render :edit
      elsif new_gender_equality.save
        redirect_to fund_settings_institution_path(fund_id: @institution.fund.id,
                                                   id: @institution.id,
                                                   selected_tab: 'impact_and_esg',
                                                   anchor: 'positive_impact_tab')
      else
        flash.now[:alert] = new_gender_equality.errors.full_messages
        @institution_gender_equality = new_gender_equality
        render :edit
      end
    end

    def update_services_offered
      services_offered = @institution.positive_impact_services_offereds.order(as_of: :desc, updated_at: :desc).first

      new_services_offered = @institution.positive_impact_services_offereds.build(services_offered_params)
      new_services_offered[:user_id] = current_user.id

      if Institution.is_current_as_of_more_recent?(services_offered.try(:as_of), services_offered_params[:as_of])
        flash.now[:alert] = 'Current Services offered data is more recent than the currently provided'
        @institution_services_offered = new_services_offered
        render :edit
      elsif new_services_offered.save
        redirect_to fund_settings_institution_path(fund_id: @institution.fund.id,
                                                   id: @institution.id,
                                                   selected_tab: 'impact_and_esg',
                                                   anchor: 'positive_impact_tab')
      else
        flash.now[:alert] = new_services_offered.errors.full_messages
        @institution_services_offered = new_services_offered
        render :edit
      end
    end

    def update_impact_indicator
      impact_indicator = @institution.institution_impact_indicators.order(as_of: :desc, updated_at: :desc).first

      new_impact_indicator = @institution.institution_impact_indicators.build(impact_indicator_params)
      new_impact_indicator[:user_id] = current_user.id

      if Institution.is_current_as_of_more_recent?(impact_indicator.try(:as_of), impact_indicator_params[:as_of])
        flash.now[:alert] = 'Current Impact indicators data is more recent than the currenlty provided'
        @institution_impact_indicator = new_impact_indicator
        render :edit
      elsif new_impact_indicator.update(impact_indicator_params)
        redirect_to fund_settings_institution_path(fund_id: @institution.fund.id,
                                                   id: @institution.id,
                                                   selected_tab: 'impact_and_esg',
                                                   anchor: 'positive_impact_tab')
      else
        flash.now[:alert] = new_impact_indicator.errors.full_messages
        @institution_impact_indicator = new_impact_indicator
        render :edit
      end
    end

    private

    def load_models
      @institution = fund.institutions.find(params[:institution_id])
      authorize @institution, policy_class: InstitutionSubentityPolicy
      @institution_alinus_result = @institution.institution_alinus_results.order(as_of: :desc, updated_at: :desc).first_or_initialize
      @institution_gender_equality = @institution.institution_esg_gender_equalities.order(as_of: :desc, updated_at: :desc).first_or_initialize
      @institution_services_offered = @institution.positive_impact_services_offereds.order(as_of: :desc, updated_at: :desc).first_or_initialize
      @institution_impact_indicator = @institution.institution_impact_indicators.order(as_of: :desc, updated_at: :desc).first_or_initialize
    end

    def alinus_result_params
      params
        .require(:institution_alinus_result)
        .permit(%I[ as_of
                    overall_sptf_alinus_score
                    define_and_monitor_social_goals
                    ensure_commitment_to_social_goals
                    product_design_to_meet_clients_need
                    treat_clients_responsibly
                    treat_employees_responsibly
                    balance_financial_and_performance
                    promote_environmental_protection])
    end

    def gender_equality_params
      params
        .require(:institution_esg_gender_equality)
        .permit(%I[ as_of
                    women_percentage_in_board
                    women_percentage_in_staff
                    financial_services_targeting_women
                    non_financial_services_targeting_women
                    training_on_responsible_finance_targeting_women
                    women_percentage_in_management
                    percentage_loans_to_women_borrowers_per_glp
                    percentage_women_among_loan_officers])
    end

    def services_offered_params
      params
        .require(:positive_impact_services_offered)
        .permit(%I[ as_of
                    mobile_banking_services
                    number_clients_using_mobile_banking
                    deposits
                    number_clients_with_deposits
                    voluntary_savings])
    end

    def impact_indicator_params
      params
        .require(:institution_impact_indicator)
        .permit(%I[ as_of
                    borrowers_count
                    female_borrowers_count
                    rural_borrowers_count
                    number_of_micro_borrowers
                    number_of_sme_borrowers
                    avg_loan_size
                    internal_impact_score
                    number_of_clients])
    end
  end
end
