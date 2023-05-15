# frozen_string_literal: true

class LoanRequestsController < ApplicationController
  include FundScoped

  before_action :set_loan_request, except: [:new, :create]

  def new
    @loan_request = fund.loan_requests.new.decorate
    authorize(loan_request)
  end

  def create
    authorize(LoanRequest.new(fund: fund))
    context = CreateLoanRequestInteractor.call(fund: fund, params: permitted_params, user: current_user)
    if context.success?
      redirect_to fund_loan_request_path(fund_id: fund.id, id: context.loan_request)
    else
      render :new
    end
  end

  def update
    authorize(loan_request)
    context = UpdateLoanRequestInteractor.call(loan_request: loan_request, params: permitted_params)
    if context.success?
      redirect_to fund_loan_request_path(fund_id: fund.id, id: loan_request)
    else
      render :edit
    end
  end

  def destroy
    authorize(loan_request)
    if loan_request.destroy
      redirect_to fund_loan_dashboards_path(fund_id: fund.id),
                  notice: I18n.t("loan_requests.destroy.succesful_destroyed")
    else
      redirect_to fund_loan_request_path(fund_id: fund.id, id: loan_request),
                  alert: I18n.t("loan_requests.destroy.destroy_error")
    end
  end

  private

  attr_reader :loan_request, :validation

  helper_method :loan_request, :validation

  def set_loan_request
    @loan_request = LoanRequest.find(params[:id]).decorate
  end

  def permitted_params
    params.require(:loan_request).permit(:institution_id, :spread, :upfront_fees, :fixed_rate,
                                         :nominal_amount, :currency_id,
                                         :tenor, :execution_probability, :repayment_type_id, :mfi_pays,
                                         :interest_payment_frequency, :loan_type_id, :tranche, :intermediary,
                                         :syndication_amount, :hedge_structure, :assignement_date,
                                         :expected_dibursement_date, :sme_window, :submitted, :approved, :waiting_list,
                                         :assigned_investment_manager_id,
                                         loan_request_documents_attributes: [:document])
  end
end
