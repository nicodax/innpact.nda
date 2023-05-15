class InvestedLoanVersionValidator < ApprovedLoanVersionValidator
  params do
    required(:executed_nominal_amount).filled(:float).value(gteq?: 0)
    required(:executed_tenor).filled(:float).value(gteq?: 0)
    required(:loan_spread).filled(:float).value(gteq?: 0).value(lteq?: 100)
    required(:executed_upfront_fees).filled(:float).value(gteq?: 0).value(lteq?: 100)
    required(:disbursement_date).filled(:date)
    required(:maturity_date).filled(:date)
    required(:executed_bond_id).filled(:integer)
    required(:loan_interest_rate_type_id).filled(:integer)
    optional(:hedge_comment).maybe(max_size?: 100)
    optional(:invested_comment).maybe(max_size?: 1000)
    required(:invested_hedge_fx_rate).filled(:decimal)
    optional(:hedge_checkbox).maybe(:integer)
    optional(:hedge_spread).maybe(:float)
    optional(:hedge_interest_rate_type_id).maybe(:integer)
  end

  rule(:hedge_checkbox, :hedge_spread, :hedge_interest_rate_type_id) do
    if values[:hedge_checkbox].present?
      key.failure("checked with hedge spread missing") if values[:hedge_spread].blank?
      key.failure("checked with hedge interest rate type missing") if values[:hedge_interest_rate_type_id].blank?
    end
  end
end
