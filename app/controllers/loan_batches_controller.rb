# frozen_string_literal: true

class LoanBatchesController < ApplicationController
  include FundScoped

  def update
    authorize Loan
    @loans = fund.loans.only_deleted.where(id: permitted_params[:loan_ids])
    loans.each { |loan| loan.restore(recursive: true) }
    redirect_to redirect_path(loans.first.category)
  end

  def destroy
    authorize Loan
    fund.loans.where(id: permitted_params[:loan_ids]).destroy_all
    redirect_to redirect_path(params[:loan_category]), notice: I18n.t('loans.destroy.succesful_destroyed')
  end

  private

  attr_reader :loans

  helper_method :loans

  def permitted_params
    params.permit(:loan_category, loan_ids: [])
  end

  def redirect_path(loan_category)
    case loan_category
    when 'accepted'
      fund_accepted_loan_dashboard_path(fund: fund)
    when 'in_waiting_list'
      fund_in_waiting_list_loan_dashboard_path(fund: fund)
    else
      fund_loan_request_dashboard_path(fund: fund)
    end
  end
end
