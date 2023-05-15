# frozen_string_literal: true

module Settings
  class CurrenciesController < SettingsController
    include FundScoped

    before_action :generate_currencies, only: %i[index upload import]
    before_action :set_currency, only: %i[edit update]
    before_action :set_setting_collection, only: %i[import index show edit new]

    def new
      generate_currencies
    end

    def import
      authorize(Currency, :create?)
      if params[:currency].nil? || params[:currency][:file].nil?
        flash.now[:alert] = I18n.t("settings.currencies.upload.upload_file")
        return render :upload
      end

      CurrenciesImporter.import_file(params[:currency][:file], current_user, fund)
      redirect_to fund_settings_currencies_path, notice: "Currencies imported" and return
    rescue StandardError => e
      flash.now[:alert] = "#{e.message} #{I18n.t('settings.currencies.upload.create_error')}"
      render :upload
    end

    private

    attr_reader :currency_rate

    helper_method :currency_rate

    def resource_class
      Currency
    end

    def generate_currencies
      @new_setting = resource_class.new
      @currency_rate = new_setting.currency_rates.build
    end

    def set_currency
      @currency = Currency.find(params[:id])
    end

    def collect
      currencies = fund.send(resource_attribute_name).includes(:current_currency_rates, :expired_currency_rates)
      @setting_collection = policy_scope(currencies).order(priority: :desc, short_name: :asc)
    end

    def setting_params
      params.require(:currency).permit(:short_name, :file, :name, :priority, country_ids: [],
                                                                             currency_rates_attributes: [:id, :rate, :created_by])
    end

    def after_create_fail_action
      :new
    end
  end
end
