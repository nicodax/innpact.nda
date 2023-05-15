# frozen_string_literal: true

module Settings
  class SettingsController < ApplicationController
    include FundScoped
    rescue_from ActiveRecord::RecordNotFound, with: :not_found

    before_action :set_setting_collection, only: %i[index new show edit]
    before_action :set_setting, only: %i[show edit update destroy]


    def index
      @new_setting = fund.instance_eval(resource_attribute_name).build.decorate
    end

    def new
      @new_setting = fund.instance_eval(resource_attribute_name).build.decorate
    end

    def edit
    end

    def create
      @new_setting = fund.instance_eval(resource_attribute_name).build(setting_params)
      authorize(new_setting)

      if new_setting.save
        redirect_to after_create_path,
                    notice: t('settings_crud.setting_success_creation', setting_name: resource_name)
      else
        set_setting_collection
        flash.now[:alert] =
          t('settings_crud.setting_error_creation',
            setting_name: resource_name.downcase) + "#{new_setting.errors.full_messages.join(',')}"
        render after_create_fail_action
      end
    end

    def update
      if setting.update_attributes(setting_params)
        redirect_to after_update_path, notice: t('settings_crud.setting_success_update', setting_name: resource_name)
      else
        flash.now[:alert] = t('settings_crud.setting_error_update', setting_name: resource_name.downcase)
        set_setting_collection
        render :edit
      end
    end

    def destroy
      if setting.destroy
        redirect_to after_delete_path, notice: t('settings_crud.setting_success_delete', setting_name: resource_name)
      else
        flash.now[:alert] =
          "#{t('settings_crud.setting_error_delete',
               setting_name: resource_name)} : #{setting.errors.full_messages.join(',')}"
        set_setting_collection
        render :show
      end
    end

    private

    attr_reader :setting, :setting_collection, :new_setting, :resource_name

    helper_method :setting, :setting_collection, :new_setting, :resource_name

    def set_setting_collection
      collect
    end

    def collect
      @setting_collection = policy_scope(fund.instance_eval(resource_attribute_name).all).order(:name)
    end

    def set_setting
      @setting = fund.instance_eval(resource_attribute_name).find(params[:id])
      authorize(setting)
    end

    def resource_class
      raise 'You must override resource_class method'
    end

    def setting_params
      raise 'You must override setting_params method'
    end

    def resource_name
      resource_class.name.titleize
    end

    def resource_attribute_name
      resource_class.name.underscore.pluralize
    end

    def after_create_path
      url_for(action: :index)
    end

    def after_update_path
      url_for(action: :show, id: setting)
    end

    def after_delete_path
      url_for(action: :index)
    end

    def after_not_found
      url_for(action: :index)
    end

    def after_create_fail_action
      :index
    end

    def not_found
      redirect_to after_not_found,
                  alert: t('settings_crud.setting_error_not_found') and return
    end
  end
end
