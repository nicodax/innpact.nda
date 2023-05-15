# frozen_string_literal: true

class RepaymentCalendarPolicy < LoanPolicy
  def creator_or_assigned
    (user == record.loan.investment_manager || user == record.loan.creation_user) &&
      record.loan.institution.investment_manager == user
  end

  def active_version_validated
    record.validated?
  end
end
