class ApprovedChangeRequestLoanVersionValidator < ApprovedLoanVersionValidator
  params do
    required(:approved_change_request_nominal_amount).filled(:float).value(gteq?: 0)
    required(:approved_change_request_tenor).filled(:float).value(gteq?: 0)
    required(:approved_change_request_spread).filled(:float).value(gteq?: 0).value(lteq?: 100)
    required(:approved_change_request_upfront_fees).filled(:float).value(gteq?: 0).value(lteq?: 100)
    required(:approved_change_request_fixed_rate).filled(:float).value(gteq?: 0).value(lteq?: 100)
    required(:approval_change_request_date).filled(:date)
    required(:deadline_approval_change_request_date).filled(:date)
    optional(:approved_change_request_comment).maybe(max_size?: 1000)
  end
end
