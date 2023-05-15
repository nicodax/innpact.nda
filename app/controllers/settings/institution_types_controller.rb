# frozen_string_literal: true

module Settings
  class InstitutionTypesController < SettingsController
    private

    def resource_class
      InstitutionType
    end

    def setting_params
      params.require(:institution_type).permit(:name, :description)
    end

  end
end
