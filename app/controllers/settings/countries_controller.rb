# frozen_string_literal: true

module Settings
  class CountriesController < SettingsController
    include FundScoped

    before_action :set_country_groups, only: %i[new create edit update]
    before_action :set_country_iso_codes, only: %i[new create edit update]
    before_action :generate_country, only: %i[index upload import]
    before_action :set_setting_collection, only: %i[import index show edit new]

    def create
      @new_setting = fund.countries.build(setting_params)
      authorize(new_setting)

      if new_setting.save
        redirect_to after_create_path,
                    notice: t('settings_crud.setting_success_creation', setting_name: resource_name) and return
      end

      set_setting_collection
      flash.now[:alert] = t('settings_crud.setting_error_creation', setting_name: resource_name.downcase)
      render after_create_fail_action, status: :unprocessable_entity
    end

    def update
      if setting.update(setting_params)
        redirect_to after_update_path,
                    notice: t('settings_crud.setting_success_update', setting_name: resource_name) and return
      end

      flash.now[:alert] = t('settings_crud.setting_error_update', setting_name: resource_name.downcase)
      set_setting_collection
      render :edit, status: :unprocessable_entity
    end

    def import
      authorize(Country, :create?)
      if params[:country].nil? || params[:country][:file].nil?
        flash.now[:alert] = I18n.t('settings.countries.upload.upload_file')
        return render :upload
      end

      begin
        CountriesImporter.import_file(params[:country][:file], current_user, fund)
        redirect_to fund_settings_countries_path, notice: t('settings.countries.upload.countries_imported') and return
      rescue StandardError => e
        flash.now[:alert] = e.message
        render :upload
      end
    end

    private

    def resource_class
      Country
    end

    def generate_country
      @new_setting = resource_class.new
    end

    def setting_params
      params.require(:country).permit(:name, :created_by, :iso_code, :population, :rating, :gdp,
                                      :gdp_per_capita, :gni, :gni_per_capita, :mimosa_score,
                                      :is_a_high_income_country, :country_group_id)
    end

    def after_create_fail_action
      :new
    end

    def set_country_groups
      @country_groups = fund.country_groups.order('name ASC')
    end

    def set_country_iso_codes
      @country_iso_codes = ISO3166::Country.all.sort_by(&:alpha2)
                                           .map { |user| ["#{user.alpha2} - #{user.iso_short_name}", user.alpha2] }
    end
  end
end
