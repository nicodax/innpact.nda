module Settings
  class DefaultLimitsController < SettingsController
    before_action :set_limits, only: [:new, :show, :edit]

    private

    attr_reader :default_limits, :exception_limits

    helper_method :default_limits, :exception_limits

    def set_limits
      @default_limits = DefaultLimit.where(fund_id: params[:fund_id])
      @exception_limits = LimitException.all.where(fund_id: params[:fund_id])
    end

    def setting_params
      params.require(:default_limit).permit(:model, :value, :description)
    end

    def resource_class
      DefaultLimit
    end

    def after_create_path
      url_for(action: :new)
    end

    def after_create_fail_action
      :new
    end

    def after_delete_path
      fund_settings_limits_path
    end

    def collect
      set_limits
    end
  end
end
