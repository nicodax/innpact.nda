class FundDecorator < ApplicationDecorator
  decorates Fund
  decorates_association :fund_usd_amounts

  def previous_amounts
    fund_usd_amounts.order(created_at: :desc).drop(1)
  end

  def current_amount
    object.current_amount.decorate if object.current_amount
  end

  def loan_request_count
    LoanPolicy::Scope.new(h.current_user, loans.loan_request).resolve.size
  end

  def waiting_list_loan_count
    LoanPolicy::Scope.new(h.current_user, loans.waiting_list).resolve.size
  end

  def accepted_loan_count
    LoanPolicy::Scope.new(h.current_user, loans.accepted).resolve.size
  end

  def matured_loan_count
    LoanPolicy::Scope.new(h.current_user, loans.matured).resolve.size
  end

  def deleted_loan_count
    LoanPolicy::Scope.new(h.current_user, loans.only_deleted).resolve.size
  end

  def upcoming_repayment_lines
    loans = fund_user_loans.map(&:id)
    lines = RepaymentCalendarLine.for_loan_ids(loans)
    lines = lines.pending_status.order(repayment_date: :asc)
    RepaymentCalendarLineDecorator.decorate_collection(lines).where('repayment_date >= ?', Time.zone.now)
  end

  def fund_user_loans
    user = h.current_user
    loan = Loan.for_fund(object)
    LoanPolicy::Scope.new(user, loan).resolve
  end
end
