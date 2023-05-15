# frozen_string_literal: true

module Settings
  class CovenantsController < SettingsController
    skip_before_action :set_setting_collection

    def index
      authorize Institution, policy_class: CovenantPolicy
      set_resources
    end

    def new
      authorize Institution, policy_class: CovenantPolicy
      set_resources
    end

    def create
      authorize Institution, policy_class: CovenantPolicy
      set_resources

      begin
        @result = InstitutionCovenantsImporter.import_file(file: params.dig(:institution_covenant, :file),
                                                           fund: fund, current_user: current_user,
                                                           institutions: @institutions)
      rescue StandardError => e
        flash.now[:alert] = e.message
      end

      render :new
    end

    def resource_class
      InstitutionCovenant
    end

    def setting_params
      params.require(:institution_covenant).permit(:file)
    end

    def set_resources
      @institutions = policy_scope(fund.institutions)
      @new_setting = resource_class.new
    end
  end
end
