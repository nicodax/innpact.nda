class MaturedLoanVersionValidator < ApprovedLoanVersionValidator
  params do
    required(:executed_nominal_amount).filled(:float).value(gteq?: 0)
    required(:executed_tenor).filled(:float).value(gteq?: 0)
    required(:loan_spread).filled(:float).value(gteq?: 0).value(lteq?: 100)
    required(:executed_upfront_fees).filled(:float).value(gteq?: 0).value(lteq?: 100)
    required(:disbursement_date).filled(:date)
    required(:maturity_date).filled(:date)
    required(:executed_bond_id).filled(:integer)
    required(:loan_interest_rate_type_id).filled(:integer)
  end
end
