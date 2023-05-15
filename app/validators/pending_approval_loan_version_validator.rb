class PendingApprovalLoanVersionValidator < RatifiedLoanVersionValidator
  params do
    required(:pending_approval_nominal_amount).filled(:float).value(gteq?: 0)
    required(:pending_approval_tenor).filled(:float).value(gteq?: 0)
    required(:pending_approval_spread).filled(:float).value(gteq?: 0).value(lteq?: 100)
    required(:pending_approval_upfront_fees).filled(:float).value(gteq?: 0).value(lteq?: 100)
    required(:pending_approval_fixed_rate).filled(:float).value(gteq?: 0).value(lteq?: 100)
    required(:pending_approval_date).filled(:date)
    required(:deadline_pending_approval_date).filled(:date)
    optional(:pending_approval_comment).maybe(max_size?: 1000)
  end
end
