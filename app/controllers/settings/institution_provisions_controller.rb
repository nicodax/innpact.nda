# frozen_string_literal: true

module Settings
  class InstitutionProvisionsController < SettingsController
    before_action :set_institution

    def create
      percentage = permitted_params[:percentage].try(:to_f)

      if percentage.present?
        context = CreateInstitutionProvisionInteractor.call(institution: institution, user: current_user,
                                                            provision_percentage: percentage / 100, comment: permitted_params[:comment])

        if context.success?
          flash.notice = t('settings_crud.setting_success_creation',
                           setting_name: I18n.t('activerecord.models.institution_provision.one'))
        else
          flash.alert = t('settings_crud.setting_error_creation',
                          setting_name: I18n.t('activerecord.models.institution_provision.one')) + ' ' + context[:error_message]
        end
      else
        flash.alert = t('settings_crud.setting_error_creation',
                        setting_name: I18n.t('activerecord.models.institution_provision.one'))
      end

      redirect_to fund_settings_institution_path(id: institution, anchor: 'provisions_tab')
    end

    def validate
      institution_provision = institution.institution_provisions.find(params[:id])
      authorize(institution_provision)

      result = ValidateInstitutionProvisionInteractor.call(institution_provision: institution_provision,
                                                           user: current_user, validated: params[:validated])

      if result.success? && result.institution_provision.validated?
        flash.notice = t('settings.institutions.provisions.validation.validated')
      elsif result.success? && result.institution_provision.rejected?
        flash.alert = t('settings.institutions.provisions.validation.rejected')
      else
        flash.alert = t('settings.institutions.provisions.validation.failed')
      end

      redirect_to fund_settings_institution_path(id: institution, anchor: 'provisions_tab')
    end

    private

    attr_reader :institution

    def permitted_params
      params.require(:institution_provision).permit(:percentage, :comment)
    end

    def set_institution
      @institution = fund.institutions.find(params[:institution_id])
    end
  end
end
