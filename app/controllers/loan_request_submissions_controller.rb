# frozen_string_literal: true

class LoanRequestSubmissionsController < ApplicationController
  def create
    fund = Fund.find(params[:fund_id])
    loan_request = LoanRequest.find(params[:loan_request_id])
    authorize(loan_request)
    context = SubmitLoanRequestInteractor.call(fund: fund, loan_request: loan_request)
    if !context.success?
      flash.now[:alert] = I18n.t("loan_requests.submission.error", error: context.error)
    end
    redirect_to fund_loan_request_path(fund_id: fund.id, id: loan_request)
  end
end
