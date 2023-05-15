# frozen_string_literal: true

class RepaymentCalendarsController < ApplicationController
  include FundScoped

  before_action :set_loan
  before_action :set_repayment_calendar, only: [:edit]

  def edit
  end

  def update
    context = UpdateRepaymentCalendarInteractor.call(loan: loan, params: permitted_params, user: current_user)
    if context.success?
      redirect_to fund_loan_repayment_calendar_dashboards_path, notice: update_notice_message
    else
      @calendar = context.repayment_calendar
      flash.now[:alert] =
        I18n.t("repayment_calendars.errors.cannot_update_repayment_calendar") + " : " + context.error_message
      render :edit
    end
  end

  private

  attr_reader :loan, :calendar

  helper_method :loan, :calendar

  def set_loan
    @loan ||= Loan.find(params[:loan_id])
  end

  def set_repayment_calendar
    @calendar ||= loan.active_repayment_calendar.decorate
  end

  def update_notice_message
    i18n_key = if current_user.investment_manager?
                 'action_notice.temporary_success_update'
               else
                 'action_notice.success_update'
               end

    I18n.t(i18n_key, object_name: I18n.t('activerecord.models.repayment_calendar.one').capitalize)
  end

  def permitted_params
    params.require(:repayment_calendar).permit(principal_repayment_lines_attributes: {},
                                               interest_repayment_lines_attributes: {})
  end
end
