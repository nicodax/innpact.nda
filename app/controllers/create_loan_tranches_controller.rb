# frozen_string_literal: true

class CreateLoanTranchesController < ApplicationController
  include FundScoped

  before_action :set_loan

  def create
    authorize(loan)
    context = CreateLoanTrancheInteractor.call(loan: loan)
    if context.success?
      new_loan = Loan.where(original_loan_id: loan.id).last
      redirect_to edit_fund_loan_path(fund_id: fund.id, id: new_loan.id)
    else
      redirect_to edit_fund_loan_path(fund_id: fund.id, id: loan.id), alert: context.error_message
    end
  end

  private

  attr_reader :loan

  helper_method :loan

  def set_loan
    @loan ||= fund.loans.find(params[:loan_id])
  end
end
