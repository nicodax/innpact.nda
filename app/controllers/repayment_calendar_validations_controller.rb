# frozen_string_literal: true

class RepaymentCalendarValidationsController < ApplicationController
  def create
    authorize(loan, :validate_or_reject?)
    if repayment_calendar != loan.active_repayment_calendar
      redirect_to fund_loan_path(fund_id: fund, id: loan),
                  alert: I18n.t("repayment_calendars.validation.not_active_version")
    else
      if validated
        context = ValidateRepaymentCalendarInteractor.call(repayment_calendar: repayment_calendar, user: current_user)
      else
        context = RejectRepaymentCalendarInteractor.call(repayment_calendar: repayment_calendar, user: current_user)
      end

      if context.success?
        redirect_to fund_loan_repayment_calendar_dashboards_path(fund_id: fund, loan_id: loan),
                    notice: I18n.t("repayment_calendars.validation.repayment_calendar_#{validated ? "validated" : "rejected"}")
      else
        redirect_to fund_loan_repayment_calendar_dashboards_path(fund_id: fund, loan_id: loan),
                    alert: I18n.t("repayment_calendars.validation.cannot_#{validated ? "validate" : "reject"}_repayment_calendar")
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

  def repayment_calendar
    RepaymentCalendar.find(params[:repayment_calendar_id])
  end
end
