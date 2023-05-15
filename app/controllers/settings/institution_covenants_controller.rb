# frozen_string_literal: true

module Settings
  class InstitutionCovenantsController < SettingsController
    before_action :set_institution
    before_action :set_setting_collection, only: %i[index]

    def index
      @institution_covenant = institution.build_institution_covenant(fund_id: fund.id)
      authorize @institution_covenant
    end

    def new
      @new_setting = institution.build_institution_covenant(fund_id: fund.id)
    end

    def create
      @new_setting = institution.build_institution_covenant(setting_params)
      authorize(@new_setting)

      if @new_setting.save
        redirect_to(after_create_path,
                    notice: t('settings_crud.setting_success_creation', setting_name: resource_name)) and return
      end

      set_setting_collection
      flash.now[:alert] = @new_setting.errors.full_messages
      render after_create_fail_action, status: :unprocessable_entity
    end

    def resource_class
      InstitutionCovenant
    end

    private

    attr_reader :institution, :institution_covenant

    helper_method :institution, :institution_covenant

    def set_institution
      @institution = fund.institutions.find(params[:institution_id])
    end

    def set_setting
      @setting = fund.institutions.find(params[:institution_id]).institution_covenant
      authorize(setting)
    end

    def setting_params
      params.require(:institution_covenant).permit(:name,
                                                   :par30,
                                                   :par30_limit,
                                                   :par30_refy,
                                                   :par30_refy_limit,
                                                   :roa,
                                                   :roa_limit,
                                                   :adj_roa,
                                                   :adj_roa_limit,
                                                   :open_fx_exposure,
                                                   :open_fx_exposure_limit,
                                                   :open_loan_position,
                                                   :open_loan_position_limit,
                                                   :fund_id,
                                                   :car,
                                                   :car_limit,
                                                   :deposits_liabilities,
                                                   :deposits_liabilities_limit,
                                                   :maturity_matching_if_applicable,
                                                   :maturity_matching_if_applicable_limit,
                                                   :liquid_assets_deposits_if_applicable,
                                                   :liquid_assets_deposits_if_applicable_limit)
    end

    def after_create_fail_action
      :new
    end

    def after_create_path
      fund_settings_institution_path(fund_id: fund.id, id: institution.id, anchor: 'covenant_tab')
    end

    def after_update_path
      fund_settings_institution_path(fund_id: fund.id, id: institution.id, anchor: 'covenant_tab')
    end

    def after_delete_path
      fund_settings_institution_path(fund_id: fund.id, id: institution.id, anchor: 'covenant_tab')
    end
  end
end
