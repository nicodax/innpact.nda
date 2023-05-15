class DeletedLoanDecorator < LoanDecorator
  def active_loan_version
    loan_versions.only_deleted.detect { |v|
      v.version_number == last_loan_version && v.version_status != LoanVersion::VERSION_STATUS_REJECTED
    }
  end

  def status
    active_loan_version.status
  end
end
