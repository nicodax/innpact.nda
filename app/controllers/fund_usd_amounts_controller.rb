# frozen_string_literal: true

class FundUsdAmountsController < ApplicationController
  before_action :get_fund

  def new
    @fund_usd_amount = fund.fund_usd_amounts.build
    authorize @fund_usd_amount
  end

  def create
    @fund_usd_amount = fund.fund_usd_amounts.build(permitted_params)
    authorize @fund_usd_amount
    if fund_usd_amount.save
      redirect_to fund_path(id: fund.id)
    else
      render :new
    end
  end

  private

  attr_reader :fund, :fund_usd_amount

  helper_method :fund, :fund_usd_amount

  def get_fund
    @fund = Fund.find(params[:fund_id])
  end

  def permitted_params
    params.require(:fund_usd_amount).permit(:amount)
  end
end
