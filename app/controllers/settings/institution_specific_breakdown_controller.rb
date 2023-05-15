# frozen_string_literal: true

module Settings
  class InstitutionSpecificBreakdownController < ApplicationController
    include FundScoped
    before_action :load_models

    def edit; end

    def update_specific_breakdowns
      specific_breakdown = @institution.institution_specific_breakdowns.order(as_of: :desc, updated_at: :desc).first

      new_specific_breakdown = @institution.institution_specific_breakdowns.build(specific_breakdown_params)
      new_specific_breakdown[:user_id] = current_user.id

      if Institution.is_current_as_of_more_recent?(specific_breakdown.try(:as_of), specific_breakdown_params[:as_of])
        flash.now[:alert] = "Current breakdown data is more recent than the currently provided"
        render :edit
      elsif new_specific_breakdown.save
        redirect_to fund_settings_institution_path(fund_id: @institution.fund.id, id: @institution.id, anchor: 'portfolio_breakdown_tab')
      else
        # flash.now[:alert] = new_specific_breakdown.errors.messages[:institution]
        flash.now[:alert] = new_specific_breakdown.errors.full_messages
        @institution_specific_brekadown = new_specific_breakdown
        render :edit
      end
    end

    private

    def load_models
      @institution = fund.institutions.find(params[:institution_id])
      authorize @institution, policy_class: InstitutionSubentityPolicy
      @institution_specific_brekadown =
        @institution.institution_specific_breakdowns.order(as_of: :desc, updated_at: :desc).first_or_initialize
    end

    def specific_breakdown_params
      params
        .require(:institution_specific_breakdown)
        .permit(%I[as_of microfinance_portfolio_size sme_portfolio_size_under_35k sme_portfolio_size_under_50k percentage_loans_to_rural_borrowers_per_glp
                   trade_and_services agriculture production consumption by_sector_other
                   microenterprise sme corporate housing personal by_loan_purpose_other])
    end
  end
end
