# frozen_string_literal: true

class MaturedLoanDashboardsController < LoanDashboardsController
  private

  def loan_category
    :matured
  end

  def permitted_params
    params.has_key?(:loan_search) ? params.require(:loan_search).permit(:page, :im_group_id, :innpact_loan_id, :pool_id, :noval, :institution_id, :institution_group_id, :repayment_type_id,
                                                                        :country_id, :country_group_id, :status, :currency_id, :loan_type_id, :critical_cases, :institution_type_id,
                                                                        :executed_bond_id, :loan_interest_rate_type_id,
                                                                        executed_nominal_amount_usd: [:begin, :end], executed_nominal_amount: [:begin, :end], executed_tenor: [:begin, :end], loan_spread: [:begin, :end], executed_upfront_fees: [:begin, :end], executed_fixed_rate: [:begin, :end],
                                                                        disbursement_date: [:begin, :end], maturity_date: [:begin, :end], nav_usd: [:begin, :end], net_position_value: [:begin, :end], gross_position_value: [:begin, :end],
                                                                        provision_date: [:begin, :end], provision_value_usd: [:begin, :end], vrr_maturity_date: [:begin, :end], repayment_type_id: [:begin, :end],) : {}
  end

  def search_path
    fund_matured_loan_dashboard_path(fund: fund)
  end
end
