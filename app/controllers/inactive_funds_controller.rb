# frozen_string_literal: true

class InactiveFundsController < ApplicationController
  def index
    authorize(:inactive_fund, :index?)

    @archived_funds = Fund.inactive
    @investment_managers = User.for_fund(@archived_funds.pluck(:id)).group_by(&:fund_id)
  end

  def show
    authorize(:inactive_fund, :show?)

    @fund = Fund.find(params[:id])
    @investment_managers = User.for_fund(@fund.id)
    @general_managers = User.with_role(User::ROLE_GENERAL_MANAGER)
    @administrators = User.with_role(User::ROLE_ADMINISTRATOR)
  end
end
