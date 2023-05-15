# frozen_string_literal: true

class RollbackToInvestedsController < ApplicationController
  include FundScoped
  before_action :set_loan

  def update
    authorize(loan)
    context = RollbackLoanFromMaturedToInvestedInteractor.call(loan: loan)
    if context.success?
      redirect_to fund_loan_path(fund_id: fund.id, id: loan.id)
    else
      redirect_to fund_loan_path(fund_id: fund.id, id: loan.id), alert: context.error_message
    end
  end

  private

  attr_reader :loan

  helper_method :loan

  def set_loan
    @loan ||= fund.loans.find(params[:loan_id])
  end
end
