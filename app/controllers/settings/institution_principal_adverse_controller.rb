# frozen_string_literal: true

module Settings
  class InstitutionPrincipalAdverseController < ApplicationController
    include FundScoped
    before_action :load_models

    def edit; end

    def update_pai_indicator
      pai_indicator = @institution.institution_esg_pai_indicators.order(as_of: :desc, updated_at: :desc).first

      new_pai_indicator = @institution.institution_esg_pai_indicators.build(pai_indicator_params)
      new_pai_indicator[:user_id] = current_user.id

      if Institution.is_current_as_of_more_recent?(pai_indicator.try(:as_of), pai_indicator_params[:as_of])
        flash.now[:alert] = 'Current PAI indicators data is more recent than the currently provided'
        @institution_pai_indicator = new_pai_indicator
        render :edit
      elsif new_pai_indicator.save
        redirect_to fund_settings_institution_path(fund_id: @institution.fund.id,
                                                   id: @institution.id,
                                                   selected_tab: 'impact_and_esg',
                                                   anchor: 'principal_adverse_impact_tab')
      else
        flash.now[:alert] = new_pai_indicator.errors.full_messages
        @institution_pai_indicator = new_pai_indicator
        render :edit
      end
    end

    def update_environment_pai
      environment_pai_list = @institution.additional_pais_environments.order(as_of: :desc, updated_at: :desc)

      environment_pai = environment_pai_list.where(environment_pai_reported: environment_pai_params[:environment_pai_reported]).first if environment_pai_params.key?(:environment_pai_reported)

      new_environment_pai = @institution.additional_pais_environments.build(environment_pai_params)
      new_environment_pai[:user_id] = current_user.id

      if Institution.is_current_as_of_more_recent?(environment_pai.try(:as_of), environment_pai_params[:as_of])
        flash.now[:alert] = 'Current Additional PAIs - Social data is more recent than the currently provided'
        @environment_pai = new_environment_pai
        render :edit
      elsif new_environment_pai.save
        if !params['add_another'].nil? && params['add_another'] == 'true'
          redirect_to fund_settings_institution_institution_principal_adverse_edit_path(fund_id: params[:fund_id],
                                                                                        institution_id: params[:institution_id],
                                                                                        anchor: 'additional_pais_environments'),
                      class: 'cta text-center mb5'
        else
          redirect_to fund_settings_institution_path(fund_id: @institution.fund.id,
                                                     id: @institution.id,
                                                     selected_tab: 'impact_and_esg',
                                                     anchor: 'principal_adverse_impact_tab')
        end
      else
        flash.now[:alert] = new_environment_pai.errors.full_messages
        @environment_pai = new_environment_pai
        render :edit
      end
    end

    def delete_environment_pai
      deleted_environment_pai = @institution.additional_pais_environments.find(params[:environment_pai_id])
      environment_pais = @institution.additional_pais_environments.where(environment_pai_reported: deleted_environment_pai.environment_pai_reported)
      environment_pais.each(&:delete)
      redirect_to fund_settings_institution_institution_principal_adverse_edit_path(fund_id: params[:fund_id], institution_id: params[:institution_id]), class: 'cta text-center mb5'
    end

    def update_social_pai
      social_pai_list = @institution.additional_pais_socials.order(as_of: :desc, updated_at: :desc)

      social_pai = social_pai_list.where(social_pai_reported: social_pai_params[:social_pai_reported]).first if social_pai_params.key?(:social_pai_reported)

      new_social_pai = @institution.additional_pais_socials.build(social_pai_params)
      new_social_pai[:user_id] = current_user.id

      if Institution.is_current_as_of_more_recent?(social_pai.try(:as_of), social_pai_params[:as_of])
        flash.now[:alert] = 'Current Additional PAIs - Social data is more recent than the currently provided'
        @social_pai = new_social_pai
        render :edit
      elsif new_social_pai.save
        if !params['add_another'].nil? && params['add_another'] == 'true'
          redirect_to fund_settings_institution_institution_principal_adverse_edit_path(fund_id: params[:fund_id],
                                                                                        institution_id: params[:institution_id],
                                                                                        anchor: 'additional_pais_socials'),
                      class: 'cta text-center mb5'
        else
          redirect_to fund_settings_institution_path(fund_id: @institution.fund.id,
                                                     id: @institution.id,
                                                     selected_tab: 'impact_and_esg',
                                                     anchor: 'principal_adverse_impact_tab')
        end
      else
        flash.now[:alert] = new_social_pai.errors.full_messages
        @social_pai = new_social_pai
        render :edit
      end
    end

    def delete_social_pai
      deleted_social_pai = @institution.additional_pais_socials.find(params[:social_pai_id])
      social_pais = @institution.additional_pais_socials.where(social_pai_reported: deleted_social_pai.social_pai_reported)
      social_pais.each(&:delete)
      redirect_to fund_settings_institution_institution_principal_adverse_edit_path(fund_id: params[:fund_id], institution_id: params[:institution_id]), class: 'cta text-center mb5'
    end

    private

    def load_models
      @institution = fund.institutions.find(params[:institution_id])
      authorize @institution, policy_class: InstitutionSubentityPolicy
      @institution_pai_indicator = @institution.institution_esg_pai_indicators.order(as_of: :desc, updated_at: :desc).first_or_initialize
      @environment_pai = @institution.additional_pais_environments.order(as_of: :desc, updated_at: :desc).first_or_initialize
      @social_pai = @institution.additional_pais_socials.order(as_of: :desc, updated_at: :desc).first_or_initialize
    end

    def pai_indicator_params
      params
        .require(:institution_esg_pai_indicator)
        .permit(%I[ as_of
                    scope_1_emissions
                    scope_2_emissions
                    scope_3_emissions
                    carbon_footprint
                    ghg_intensity_investee_companies
                    exposure_companies_active_in_fossil_fuel_sector
                    share_of_non_renewable_energy_consumption_and_production
                    energy_consumption_intensity_per_high_impact_climate_sector
                    activities_negatively_affecting_biodiversity_sensitive_areas
                    emissions_to_water
                    hazardous_waste_ratio
                    violations_of_un_global_compact_principles_and_oecd_guidelines_for_multinational_enterprises
                    lack_of_processes_and_compliance_mechanisms_to_monitor_compliance_with_un_global_compact_principles
                    unadjusted_gender_pay_gap
                    board_gender_diversity
                    exposure_to_controversial_weapons])
    end

    def environment_pai_params
      params
        .require(:additional_pais_environment)
        .permit(%I[ as_of
                    environment_pai_reported
                    environment_pai_value])
    end

    def social_pai_params
      params
        .require(:additional_pais_social)
        .permit(%I[ as_of
                    social_pai_reported
                    social_pai_value])
    end
  end
end
