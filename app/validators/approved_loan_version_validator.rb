class ApprovedLoanVersionValidator < RatifiedLoanVersionValidator
  params do
    required(:approved_nominal_amount).filled(:float).value(gteq?: 0)
    required(:approved_tenor).filled(:float).value(gteq?: 0)
    required(:approved_spread).filled(:float).value(gteq?: 0).value(lteq?: 100)
    required(:approved_upfront_fees).filled(:float).value(gteq?: 0).value(lteq?: 100)
    required(:approved_fixed_rate).filled(:float).value(gteq?: 0).value(lteq?: 100)
    required(:approval_date).filled(:date)
    required(:approved_bond_id).filled(:integer)
    required(:approved_interest_rate_type_id).filled(:integer)
    required(:deadline_approval_date).filled(:date)
    optional(:approved_comment).maybe(max_size?: 1000)
  end
end
