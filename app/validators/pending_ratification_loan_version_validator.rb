class PendingRatificationLoanVersionValidator < InitialLoanVersionValidator
  params do
    required(:pending_ratification_nominal_amount).filled(:float).value(gteq?: 0)
    required(:pending_ratification_tenor).filled(:float).value(gteq?: 0)
    required(:pending_ratification_spread).filled(:float).value(gteq?: 0).value(lteq?: 100)
    required(:pending_ratification_upfront_fees).filled(:float).value(gteq?: 0).value(lteq?: 100)
    required(:pending_ratification_fixed_rate).filled(:float).value(gteq?: 0).value(lteq?: 100)
    required(:pending_ratification_date).filled(:date)
    required(:deadline_pending_ratification_date).filled(:date)
    optional(:pending_ratification_comment).maybe(max_size?: 1000)
  end
end
