module Settings
  class BondsController < SettingsController
    private

    def resource_class
      Bond
    end

    def setting_params
      params.require(:bond).permit(:name, :description)
    end
  end
end
