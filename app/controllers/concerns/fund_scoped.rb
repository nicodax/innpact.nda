require 'active_support/concern'
module FundScoped
  extend ActiveSupport::Concern
  included do
    before_action :set_fund

    attr_reader :fund
    helper_method :fund

    def set_fund
      @fund = Fund.find(params[:fund_id])
      authorize(fund, :show?)
    end

  end
end