# frozen_string_literal: true

class LoanVersionValidationsController < ApplicationController
  def show
    validate_or_reject
  end

  def create
    validate_or_reject
  end

  def validate_or_reject
    authorize(loan, :validate_or_reject?)
    if loan_version != loan.active_loan_version
      redirect_to fund_loan_path(fund_id: fund, id: loan), alert: I18n.t("loan_versions.validation.not_active_version")
    else
      if validated
        context = ValidateLoanVersionInteractor.call(loan_version: loan_version, user: current_user,
                                                     validation_object: validation_object)
      else
        context = RejectLoanVersionInteractor.call(loan_version: loan_version, user: current_user,
                                                   validation_object: validation_object)
      end

      if context.success?
        redirect_to fund_loan_path(fund_id: fund, id: loan),
                    notice: I18n.t("loan_versions.validation.loan_version_#{validated ? "validated" : "rejected"}")
      else
        redirect_to fund_loan_path(fund_id: fund, id: loan),
                    alert: I18n.t("loan_versions.validation.cannot_#{validated ? "validate" : "reject"}_loan_version") + " : " + context.error_message
      end
    end
  end

  private

  def validated
    ActiveModel::Type::Boolean.new.cast(params[:validated])
  end

  def fund
    Fund.find(params[:fund_id])
  end

  def loan
    Loan.find(params[:loan_id])
  end

  def loan_version
    LoanVersion.find(params[:version_id])
  end

  def validation_object
    params[:validation_object] || "version"
  end
end
