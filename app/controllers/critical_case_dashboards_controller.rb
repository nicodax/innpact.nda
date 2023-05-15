# frozen_string_literal: true

class CriticalCaseDashboardsController < ApplicationController
  before_action :set_fund

  def show
    set_filtered_list
  end

  def create
    set_filtered_list
    render :show
  end

  private

  attr_reader :fund, :watchlist_list, :restructuring_list, :provisions_list, :filtered_list

  helper_method :fund, :watchlist_list, :restructuring_list, :provisions_list, :filtered_list

  def permitted_params
    params.require(:critical_case_filter).permit(:watchlist, :restructuring, :provision)
  end

  def set_fund
    @fund = Fund.find(params[:fund_id]).decorate
    authorize(fund, :show?)
  end

  def set_filtered_list
    set_watchlist_list
    set_restructuring_list
    set_provisions_list
    if params.has_key?(:critical_case_filter)
      @filtered_list = Hash.new
      @filtered_list = @watchlist_list if permitted_params[:watchlist] == "1"
      @filtered_list = @filtered_list.merge(@restructuring_list) { |key, values1, values2|
        values1 | values2
      } if permitted_params[:restructuring] == "1"
      @filtered_list = @filtered_list.merge(@provisions_list) { |key, values1, values2|
        values1 | values2
      } if permitted_params[:provision] == "1"
    else
      @filtered_list = @watchlist_list.merge(@restructuring_list) { |key, values1, values2|
                         values1 | values2
                       }.merge(@provisions_list) { |key, values1, values2| values1 | values2 }
    end
  end

  def set_watchlist_list
    @watchlist_list = LoanDecorator.decorate_collection(fund.fund_user_loans.invested.watchlist).group_by { |l|
      l.institution.decorate
    }
  end

  def set_restructuring_list
    @restructuring_list = LoanDecorator.decorate_collection(fund.fund_user_loans.invested.restructuring).group_by { |l|
      l.institution.decorate
    }
  end

  def set_provisions_list
    @provisions_list = LoanDecorator.decorate_collection(fund.fund_user_loans.invested.provision).group_by { |l|
      l.institution.decorate
    }
  end
end
