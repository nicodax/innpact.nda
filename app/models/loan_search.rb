# frozen_string_literal: true

class LoanSearch
  include ActiveModel::Model

  attr_accessor :im_group_id, :innpact_loan_id, :status, :proposed_nominal_amount_usd,
                :proposed_nominal_amount, :proposed_tenor, :proposed_upfront_fees,
                :proposed_fixed_rate, :assignment_date, :deadline_assignment_date, :approval_date,
                :deadline_approval_date, :expected_disbursement_date, :probabilities, :pool_id,
                :institution_id, :currency_id, :loan_type_id, :repayment_type_id, :fund, :user,
                :institution_group_id, :country_id, :country_group_id, :proposed_spread, :ratified_nominal_amount_usd,
                :ratified_nominal_amount, :ratified_tenor, :ratified_spread,
                :ratified_upfront_fees, :ratified_fixed_rate, :approved_nominal_amount_usd,
                :approved_nominal_amount, :approved_tenor, :approved_spread,
                :approved_upfront_fees, :approved_fixed_rate, :loan_category, :specific_approval_condition,
                :ratification_date, :executed_upfront_fees, :executed_fixed_rate,
                :deadline_ratification_date, :noval, :critical_cases,
                :executed_bond_id, :approved_bond_id, :approved_interest_rate_type_id, :loan_interest_rate_type_id,
                :executed_nominal_amount_usd, :executed_nominal_amount, :executed_tenor, :loan_spread,
                :disbursement_date, :maturity_date, :nav_usd, :net_position_value, :gross_position_value,
                :provision_date, :provision_value_usd, :vrr, :vrr_maturity_date, :page, :institution_type_id

  def loans
    (empty_search ? scope : find_loans)
  end

  def find_loans
    filter = LoansFilter.new(scope)
    filter.populate_from_params(search_params)
    filter.loans
  end

  def empty_search
    search_params.all?(&:blank?)
  end

  private

  def scope
    LoanPolicy::Scope.new(user, loans_by_category).resolve
  end

  def search_params
    @search_params ||= instance_values.except('fund', 'user', 'loan_category').inject({}) do |h, kv|
      if kv.last.is_a?(Hash)
        cleaned_hash = kv.last.select { |_, v| v.present? }
        h[kv.first] = cleaned_hash if cleaned_hash.any?
      else
        h[kv.first] = kv.last if kv.last.present?
      end
      h
    end
  end

  def loans_by_category
    case loan_category.to_s
    when 'loan_request'
      fund.loans.loan_request
    when 'accepted'
      fund.loans.accepted
    when 'matured'
      fund.loans.matured
    when 'in_waiting_list'
      fund.loans.waiting_list
    end
  end
end
