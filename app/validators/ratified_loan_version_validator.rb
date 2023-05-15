class RatifiedLoanVersionValidator < InitialLoanVersionValidator
  params do
    required(:ratified_nominal_amount).filled(:float).value(gteq?: 0)
    required(:ratified_tenor).filled(:float).value(gteq?: 0)
    required(:ratified_spread).filled(:float).value(gteq?: 0).value(lteq?: 100)
    required(:ratified_upfront_fees).filled(:float).value(gteq?: 0).value(lteq?: 100)
    required(:ratified_fixed_rate).filled(:float).value(gteq?: 0).value(lteq?: 100)
    required(:ratification_date).filled(:date)
    required(:deadline_ratification_date).filled(:date)
    optional(:ratified_comment).maybe(max_size?: 1000)
  end
end
