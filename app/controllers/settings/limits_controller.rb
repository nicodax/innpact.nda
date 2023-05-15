module Settings
  class LimitsController < ApplicationController
    include FundScoped

    before_action :set_limits, only: [:index]

    def index; end

    private

    def set_limits
      authorize(DefaultLimit)
      authorize(LimitException)
      @default_limits = DefaultLimit.where(fund_id: params[:fund_id])
      @exception_limits = LimitException.all.where(fund_id: params[:fund_id])
    end
  end
end
