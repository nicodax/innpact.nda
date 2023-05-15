module Settings
  class LoanTypesController < SettingsController
    private

    def resource_class
      LoanType
    end

    def setting_params
      params.require(:loan_type).permit(:name, :description)
    end
  end
end
