# frozen_string_literal: true

class RollbackLoanFromMaturedToInvestedInteractor
  include Interactor

  def call
    Loan.transaction do
      update_loan
    rescue StandardError => e
      context.fail!
    end
  end

  delegate :loan, to: :context

  private

  def update_loan
    last_version = loan.last_loan_version
    old_version = loan.loan_versions.find_by(version_number: last_version-1)
    new_version = old_version.copy
    new_version.version_number = last_version + 1

    loan.last_loan_version = last_version + 1
    persisted = loan.save
    context.fail!(error: "Impossible to rollback") unless persisted
  end

end
