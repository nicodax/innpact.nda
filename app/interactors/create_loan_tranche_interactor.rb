# frozen_string_literal: true

class CreateLoanTrancheInteractor
  include Interactor

  def call
    Loan.transaction do
      create_loan
    rescue StandardError => e
      context.fail!
    end
  end

  delegate :loan, to: :context

  private

  def create_loan
    new_version = loan.copy
    new_version.original_loan_id = loan.id
    new_version.copied_at = DateTime.now
    new_version.innpact_loan_id = last_innpact_loan_id + 1
    persisted = new_version.save
    context.fail!(error: I18n.t('loans.create.error_tranche')) unless persisted
  end

  def last_innpact_loan_id
    Loan.with_deleted.maximum(:innpact_loan_id)
  end

end
