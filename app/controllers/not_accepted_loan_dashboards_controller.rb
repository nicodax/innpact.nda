# frozen_string_literal: true

class NotAcceptedLoanDashboardsController < LoanDashboardsController
  private

  def permitted_params
    params.has_key?(:loan_search) ? params.require(:loan_search).permit(:page, :loan_category, :im_group_id, :innpact_loan_id, :status,
                                                                        :proposed_upfront_fees, :proposed_fixed_rate, :probabilities, :pool_id, :country_group_id,
                                                                        :institution_id, :currency_id, :loan_type_id, :repayment_type_id, :institution_group_id, :institution_type_id, :specific_approval_condition,
                                                                        :country_id, approval_date: [:begin, :end], assignment_date: [:begin, :end], deadline_assignment_date: [:begin, :end],
                                                                                     deadline_approval_date: [:begin, :end], expected_disbursement_date: [:begin, :end], ratification_date: [:begin, :end], deadline_ratification_date: [:begin, :end],
                                                                                     proposed_nominal_amount: [:begin, :end], proposed_tenor: [:begin, :end], proposed_spread: [:begin, :end],
                                                                                     proposed_upfront_fees: [:begin, :end], proposed_fixed_rate: [:begin, :end], ratified_nominal_amount: [:begin, :end],
                                                                                     ratified_tenor: [:begin, :end], ratified_spread: [:begin, :end], ratified_upfront_fees: [:begin, :end], ratified_fixed_rate: [:begin, :end],
                                                                                     approved_nominal_amount: [:begin, :end], approved_tenor: [:begin, :end], approved_spread: [:begin, :end], approved_upfront_fees: [:begin, :end],
                                                                                     approved_fixed_rate: [:begin, :end], probabilities: [:begin, :end]) : {}
  end
end
