# frozen_string_literal: true

class InstitutionMailer < ApplicationMailer
  def institution_provision_validation(institution_provision)
    @institution_provision = institution_provision
    @recipient = institution_provision.creation_user

    return unless @recipient.user_setting.allows_provisions_validation_mail?

    mail(
      to: "#{@recipient.full_name} <#{@recipient.email}>",
      subject: t("mailers.admin_institution_provision_validation.#{institution_provision.version_status}_subject",
                 institution_name: institution_provision.institution.name,
                 meta: subject_metadata)
    )
  end

  def institution_provision_update(institution_provision, recipient, admin_or_gm_user)
    return if (admin_or_gm_user && recipient.user_setting.allows_provisions_crud_mail? == false) ||
              (recipient.user_setting.allows_provisions_crud_mail? == false && (recipient.administrator? || recipient.general_manager?) == false)

    @institution = institution_provision.institution
    @creation_user_name = institution_provision.creation_user.full_name

    mail(
      to: "#{recipient.full_name} <#{recipient.email}>",
      subject: t('mailers.institution_provision_update.subject',
                 institution_name: @institution.name,
                 meta: subject_metadata)
    )
  end
end
