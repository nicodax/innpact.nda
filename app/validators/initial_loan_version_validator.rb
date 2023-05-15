class InitialLoanVersionValidator < LoanVersionValidator
  params do
    required(:proposed_nominal_amount).filled(:float).value(gteq?: 0)
    required(:proposed_tenor).filled(:float).value(gteq?: 0)
    required(:proposed_spread).filled(:float).value(gteq?: 0).value(lteq?: 100)
    required(:proposed_upfront_fees).filled(:float).value(gteq?: 0).value(lteq?: 100)
    required(:proposed_fixed_rate).filled(:float).value(gteq?: 0).value(lteq?: 100)
    required(:assignment_date).filled(:date)
    required(:deadline_assignment_date).filled(:date)
  end
end
