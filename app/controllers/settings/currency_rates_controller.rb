module Settings
  class CurrencyRatesController < SettingsController
    before_action :get_currency

    def new
      @currency_rate = currency.currency_rates.build
      authorize @currency_rate
    end

    def create
      @currency_rate = currency.currency_rates.build(setting_params)
      authorize @currency_rate
      if currency_rate.save
        redirect_to after_create_path
      else
        render :new
      end
    end

    def resource_class
      CurrencyRate
    end

    private

    attr_reader :currency, :currency_rate

    helper_method :currency, :currency_rate

    def collect
      @setting_collection = CurrencyRate.current
    end

    def get_currency
      @currency = fund.currencies.find(params[:currency_id])
    end

    def set_setting
      @setting = fund.currencies.find(params[:currency_id]).instance_eval(resource_attribute_name).find(params[:id])
      authorize(setting)
    end

    def setting_params
      params.require(:currency_rate).permit(:currency_id, :rate, :created_by)
    end

    def after_create_path
      fund_settings_currency_path(id: currency.id)
    end

    def after_update_path
      fund_settings_currency_path(id: currency.id)
    end

    def after_delete_path
      fund_settings_currency_path(id: currency.id)
    end

    def after_create_fail_action
      :new
    end
  end
end
