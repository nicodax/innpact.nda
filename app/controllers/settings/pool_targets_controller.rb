module Settings
  class PoolTargetsController < ApplicationController
    include FundScoped

    before_action :set_pool

    def new
      @pool_target = pool.pool_targets.build
      authorize @pool_target
    end

    def create
      @pool_target = pool.pool_targets.build(permitted_params)
      authorize @pool_target
      if pool_target.save
        redirect_to fund_settings_pool_path(id: pool.id)
      else
        render :new
      end
    end

    private

    attr_reader :pool, :pool_target

    helper_method :pool, :pool_target

    def set_pool
      @pool = fund.pools.find(params[:pool_id])
    end

    def permitted_params
      params.require(:pool_target).permit(:amount_in_usd, :amount_in_percent, :is_target_in_usd_or_percent)
    end
  end
end
