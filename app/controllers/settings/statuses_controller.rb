module Settings
  class StatusesController < SettingsController
    def resource_class
      Status
    end

    def setting_params
      params.require(:status).permit(:name, :user_id, :description)
    end
  end
end
