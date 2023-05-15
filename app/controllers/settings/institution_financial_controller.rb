# frozen_string_literal: true

module Settings
  class InstitutionFinancialController < ApplicationController
    include FundScoped
    before_action :load_models

    def edit; end

    def update
      financial = @institution.institution_financials.order(as_of: :desc, updated_at: :desc).first

      new_financial = @institution.institution_financials.build(financial_params)
      new_financial[:user_id] = current_user.id

      if Institution.is_current_as_of_more_recent?(financial.try(:as_of), financial_params[:as_of])
        flash.now[:alert] = "Current financials data is more recent than the currently provided"
        @institution_financial = new_financial
        render :edit
      elsif new_financial.save
        redirect_to fund_settings_institution_path(fund_id: @institution.fund.id, id: @institution.id, anchor: 'financials_tab')
      else
        flash.now[:alert] = new_financial.errors.full_messages
        @institution_financial = new_financial
        render :edit
      end
    end

    private

    def load_models
      @institution = fund.institutions.find(params[:institution_id])
      authorize @institution, policy_class: InstitutionSubentityPolicy
      @institution_financial = @institution.institution_financials.order(as_of: :desc, updated_at: :desc).first_or_initialize
    end

    def financial_params
      params
        .require(:institution_financial)
        .permit(%I[as_of total_assets gross_loan_portfolio provision_for_loss international_liabilities domestic_liabilities
                   deposit_amount liabilities equity revenues net_income net_income_distributed_as_dividends npls write_off])
    end
  end
end
