# frozen_string_literal: true

module Settings
  class InstitutionEsgController < ApplicationController
    include FundScoped
    before_action :load_models

    def edit; end

    def update_safeguard
      safeguard = @institution.institution_esg_safeguards.order(as_of: :desc, updated_at: :desc).first

      new_safeguard = @institution.institution_esg_safeguards.build(safeguard_params)
      new_safeguard[:user_id] = current_user.id

      if Institution.is_current_as_of_more_recent?(safeguard.try(:as_of), safeguard_params[:as_of])
        flash.now[:alert] = "Current safeguard data is more recent than the currently provided"
        @institution_safeguard = new_safeguard
        render :edit
      elsif new_safeguard.save
        redirect_to fund_settings_institution_path(fund_id: @institution.fund.id,
                                                   id: @institution.id,
                                                   selected_tab: 'impact_and_esg',
                                                   anchor: 'esg_tab')
      else
        flash.now[:alert] = new_safeguard.errors.full_messages
        @institution_safeguard = new_safeguard
        render :edit
      end
    end

    def update_risk
      risk = @institution.institution_esg_risks.order(as_of: :desc, updated_at: :desc).first

      new_risk = @institution.institution_esg_risks.build(risk_params)
      new_risk[:user_id] = current_user.id

      if Institution.is_current_as_of_more_recent?(risk.try(:as_of), risk_params[:as_of])
        flash.now[:alert] = "Current risk data is more recent than the currently provided"
        @institution_risk = new_risk
        render :edit
      elsif new_risk.save
        redirect_to fund_settings_institution_path(fund_id: @institution.fund.id,
                                                   id: @institution.id,
                                                   selected_tab: 'impact_and_esg',
                                                   anchor: 'esg_tab')
      else
        flash.now[:alert] = new_risk.errors.full_messages
        @institution_risk = new_risk
        render :edit
      end
    end

    private

    def load_models
      @institution = fund.institutions.find(params[:institution_id])
      authorize @institution, policy_class: InstitutionSubentityPolicy
      @institution_safeguard = @institution.institution_esg_safeguards.order(as_of: :desc, updated_at: :desc).first_or_initialize
      @institution_risk = @institution.institution_esg_risks.order(as_of: :desc, updated_at: :desc).first_or_initialize
    end

    def safeguard_params
      params
        .require(:institution_esg_safeguard)
        .permit(%I[ as_of
                    compliance_with_fund_exclusion_list
                    compliance_with_international_labour_organization_standards
                    compliance_with_international_bill_of_human_rights
                    compliance_with_guiding_principles_on_business_and_human_rights
                    compliance_with_oecd_guidelines_for_multinational_enterprises
                    compliance_with_national_standards_and_law
                    compliance_with_client_protection_principles])
    end

    def risk_params
      params
        .require(:institution_esg_risk)
        .permit(%I[ as_of
                    internal_esg_score
                    ifc_esg_risk_financial_intermediaries_classification
                    esms_in_place_commensurate_with_risk_profile
                    tool_use_for_esg_score])
    end
  end
end
