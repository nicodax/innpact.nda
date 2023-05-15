module Settings
  class RepaymentTypesController < SettingsController
    private

    def resource_class
      RepaymentType
    end

    def setting_params
      params.require(:repayment_type).permit(:name, :description)
    end
  end
end
