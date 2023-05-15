# frozen_string_literal: true

class DeletedLoansController < ApplicationController
  include FundScoped

  def index
    authorize(Loan, policy_class: DeletedLoanPolicy)
    @deleted_loans = DeletedLoanDecorator.decorate_collection(fund.loans.only_deleted)
  end

  def update
    loan = Loan.only_deleted.find(params[:id])
    authorize(loan, policy_class: DeletedLoanPolicy)
    loan.restore
    redirect_to fund_deleted_loans_path(fund_id: fund.id)
  end

  def restore_batch
    items = params[:deletedLoans].to_unsafe_h
    loans = fund.loans.only_deleted.where(id: items.pluck("loanId"))
    authorize(loans.first, policy_class: DeletedLoanPolicy)
    loans.each { |l| l.restore(:recursive => true) }
  end

  private

  attr_reader :deleted_loans

  helper_method :deleted_loans

end
