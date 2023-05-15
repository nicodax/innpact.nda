# frozen_string_literal: true

module Settings
  class PoolsController < SettingsController
    def index
      @new_setting = fund.instance_eval(resource_attribute_name).build
      @target = new_setting.pool_targets.build
      new_setting.pool_documents.build
      new_setting.pool_legal_documents.build

      authorize(new_setting)
    end

    def show
      set_usd_amount
    end

    def create
      @new_setting = fund.instance_eval(resource_attribute_name).build(setting_params)
      new_setting.maturity_date = nil unless new_setting.has_maturity_date
      new_setting.amount_in_usd = (new_setting.amount / currency_rate(new_setting.currency_id)).round(2)
      authorize(new_setting)
      if new_setting.save
        redirect_to after_create_path, notice: t('settings_crud.setting_success_creation', setting_name: resource_name)
      else
        set_setting_collection
        flash.now[:alert] = t('settings_crud.setting_error_creation', setting_name: resource_name.downcase)
        render after_create_fail_action
      end
    end

    def update
      if assign_attributes
        redirect_to after_update_path, notice: t('settings_crud.setting_success_update', setting_name: resource_name)
      else
        flash.now[:alert] = t('settings_crud.setting_error_update', setting_name: resource_name.downcase)
        set_setting_collection
        render :edit
      end
    end

    private

    attr_reader :target

    helper_method :target

    def resource_class
      Pool
    end

    def assign_attributes
      setting.assign_attributes sanitized_setting_params
      setting.maturity_date = nil unless setting.has_maturity_date
      set_usd_amount
      setting.save
    end

    def set_usd_amount
      current_currency_rate = fund.currency_rates.where(currency_id: setting.currency_id).last&.rate
      return if current_currency_rate.blank?

      setting.amount_in_usd = (setting.amount / current_currency_rate).round(2)
    end

    def set_setting
      @setting = fund.instance_eval(resource_attribute_name).find(params[:id]).decorate
      authorize(setting)
    end

    def setting_params
      pool_params = %i[amount_in_usd amount_in_percent is_target_in_usd_or_percent]
      params.require(:pool).permit(:name, :has_maturity_date, :maturity_date, :subscription_date, :currency_id, :amount,
                                   :required_specific_reporting, :is_targeted,
                                   pool_targets_attributes: pool_params,
                                   country_ids: [], institution_ids: [], country_group_ids: [],
                                   institution_group_ids: [], institution_type_ids: [],
                                   currency_ids: [], loan_type_ids: [],
                                   pool_documents_attributes: %i[document _destroy],
                                   pool_legal_documents_attributes: [:document])
    end

    def sanitized_setting_params
      pool_documents_attributes = setting_params[:pool_documents_attributes].reject { |k, v| !v.has_key?(:document) }
      setting_params.merge(pool_documents_attributes: pool_documents_attributes)
    end

    def after_create_path
      url_for(action: :show, id: new_setting.id)
    end

    public

    def currency_rate(currency_id)
      CurrencyRate.where(currency_id: currency_id).pluck(:rate).last || 1
    end
  end
end
