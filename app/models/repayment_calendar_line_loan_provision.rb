# frozen_string_literal: true

class RepaymentCalendarLineLoanProvision < ApplicationRecord
  acts_as_paranoid

  belongs_to :loan_provision
  belongs_to :repayment_calendar_line
end
