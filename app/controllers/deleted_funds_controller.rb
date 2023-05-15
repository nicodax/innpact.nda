# frozen_string_literal: true

class DeletedFundsController < ApplicationController
  before_action :set_fund, only: %i[show restore destroy]

  def index
    authorize(:deleted_fund, :index?)

    @deleted_funds = Fund.only_deleted
    @investment_managers = User.for_fund(@deleted_funds.pluck(:id)).group_by(&:fund_id)
  end

  def show
    @investment_managers = User.for_fund(@fund.id)
    @general_managers = User.with_role(User::ROLE_GENERAL_MANAGER)
    @administrators = User.with_role(User::ROLE_ADMINISTRATOR)
  end

  def restore
    if @fund.restore(recursive: true) # @fund.update_attribute(:deleted_at, nil)
      @fund.active!
      redirect_to root_path
    else
      flash.now[:alert] = "Couldn't restore fund"
      render :show
    end
  end

  def destroy
    if @fund.really_destroy!
      redirect_to root_path, notice: 'Successfully deleted fund.'
    else
      redirect_to show_deleted_fund_path(id: @fund.id)
    end
  end

  private

  def set_fund
    authorize(:deleted_fund, :show?)

    @fund = Fund.only_deleted.find(params[:id])
  end
end
