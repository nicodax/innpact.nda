# frozen_string_literal: true

module Settings
  class CountryGroupsController < SettingsController
    before_action :set_countries, only: %i[show destroy]

    private

    def resource_class
      CountryGroup
    end

    def setting_params
      params.require(:country_group).permit(:name, :description, country_ids: [])
    end

    def set_countries
      @countries = setting.countries.order('name ASC')
    end
  end
end
