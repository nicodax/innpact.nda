# frozen_string_literal: true

class UserDashboardController < ApplicationController
  def show
    @dashboard = UserDashboardDecorator.new(current_user)
    @funds = FundPolicy::Scope.new(current_user, Fund).resolve
    @users = User.for_fund(@funds.pluck(:id)).group_by(&:fund_id)
  end

  private

  attr_reader :dashboard

  helper_method :dashboard
end
