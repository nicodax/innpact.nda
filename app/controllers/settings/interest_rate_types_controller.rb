module Settings
  class InterestRateTypesController < SettingsController
    private

    def resource_class
      InterestRateType
    end

    def setting_params
      params.require(:interest_rate_type).permit(:name, :description)
    end
  end
end
