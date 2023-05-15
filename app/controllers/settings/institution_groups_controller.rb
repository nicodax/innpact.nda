module Settings
  class InstitutionGroupsController < SettingsController
    private

    def resource_class
      InstitutionGroup
    end

    def setting_params
      params.require(:institution_group).permit(:name, :created_by)
    end
  end
end
