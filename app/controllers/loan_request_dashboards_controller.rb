# frozen_string_literal: true

class LoanRequestDashboardsController < NotAcceptedLoanDashboardsController
  private

  def loan_category
    :loan_request
  end

  def search_path
    fund_loan_request_dashboard_path(fund: fund)
  end
end
