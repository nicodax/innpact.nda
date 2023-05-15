# frozen_string_literal: true

class RepaymentCalendarDashboardsController < ApplicationController
  include FundScoped

  before_action :set_loan

  def show
    if loan.repayment_calendars.empty?
      redirect_to fund_loan_path(id: loan),
                  notice: t('.no_repayment_calendar_version')
    else
      authorize(loan)
      @dashboard = RepaymentCalendarDashboardDecorator.decorate(loan)
    end
  end

  private

  attr_reader :loan, :dashboard

  helper_method :loan, :dashboard

  def set_loan
    @loan ||= fund.loans.find(params[:loan_id])
  end
end
