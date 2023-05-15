# frozen_string_literal: true

class LoanMailer < ApplicationMailer
  def loan_creation_without_validation_link(loan_id, recipient)
    return unless recipient.user_setting.allows_loans_crud_mail?

    @loan = Loan.includes(:institution).find(loan_id)
    @investment_manager_name = recipient.full_name
    @noval = @loan.innpact_loan_id
    @mfi_name = @loan.institution.name

    mail(
      to: "#{@investment_manager_name} <#{recipient.email}>",
      subject: t('mailers.loan_creation_without_validation_link.subject', meta: subject_metadata)
    )
  end

  def loan_creation_with_validation_link(loan_id, recipient)
    return unless recipient.user_setting.allows_loans_crud_mail?

    @loan = Loan.includes(:institution).find(loan_id)
    @creation_user_name = @loan.creation_user.full_name
    @noval = @loan.innpact_loan_id
    @mfi_name = @loan.institution.name

    mail(
      to: "#{recipient.full_name} <#{recipient.email}>",
      subject: t('mailers.loan_creation_with_validation_link.subject', meta: subject_metadata)
    )
  end

  # This method sends a notification for the status change.
  def loan_update_without_validation_link(loan_version_id, recipient)
    return unless recipient.user_setting.allows_loans_crud_mail?

    loan_version = LoanVersion.includes(loan: %i[institution]).find(loan_version_id)
    @investment_manager_name = recipient.full_name
    @loan = loan_version.loan
    @noval = loan_version.loan.innpact_loan_id
    last_loan_version = LoanVersion.where(loan_id: loan_version.loan.id)
                                   .where(version_number: loan_version.version_number - 1).first
    @loan_version_status = loan_version.status
    @last_loan_version_status = last_loan_version.status
    @mfi_name = loan_version.loan.institution.name

    mail(
      to: "#{@investment_manager_name} <#{recipient.email}>",
      subject: t('mailers.loan_update_without_validation_link.subject', meta: subject_metadata)
    )
  end

  # This method sends a notification for the status change and also a link to accept or reject the change
  def loan_update_with_validation_link(loan_version_id, recipient)
    return unless recipient.user_setting.allows_loans_validation_mail?

    @loan_version_id = loan_version_id
    loan_version = LoanVersion.includes(loan: %i[institution]).find(loan_version_id)
    @loan = loan_version.loan
    @creation_user_name = loan_version.creation_user.full_name
    @noval = loan_version.loan.innpact_loan_id
    last_loan_version = LoanVersion.where(loan_id: loan_version.loan.id)
                                   .where(version_number: loan_version.version_number - 1).first
    @loan_version_status = loan_version.status
    @last_loan_version_status = last_loan_version.status
    @mfi_name = loan_version.loan.institution.name

    mail(
      to: "#{recipient.full_name} <#{recipient.email}>",
      subject: t('mailers.loan_update_with_validation_link.subject', meta: subject_metadata)
    )
  end

  # This method sends a notification for the status change and also a link to accept or reject the change
  def system_loan_update(loan_version_id_array, new_loan_status, recipient)
    @loan_updated_array = loan_version_id_array.map do |loan_version_id|
      loan_version = LoanVersion.includes(loan: %i[institution im_group]).find(loan_version_id)
      {
        loan_version_id: loan_version_id,
        loan: loan_version.loan,
        im_group_name: loan_version.loan.im_group.name,
        noval: loan_version.loan.innpact_loan_id,
        loan_version_status: new_loan_status,
        last_loan_version_status: loan_version.status,
        mfi_name: loan_version.loan.institution.name
      }
    end
    mail(
      to: "#{recipient.full_name} <#{recipient.email}>",
      subject: t('mailers.system_loan_update.subject', meta: subject_metadata)
    )
  end

  # This method sends a notification when the automatic updated loan status failed
  def system_loan_status_update_failed(loan_version_id_array, new_loan_status, recipient)
    @loan_failed_array = loan_version_id_array.map do |failure|
      loan_version = LoanVersion.includes(loan: %i[institution im_group]).find(failure[:loan_version_id])
      {
        loan_version_id: failure[:loan_version_id],
        errors: failure[:errors],
        loan: loan_version.loan,
        im_group_name: loan_version.loan.im_group.name,
        noval: loan_version.loan.innpact_loan_id,
        loan_version_status: new_loan_status,
        last_loan_version_status: loan_version.status,
        mfi_name: loan_version.loan.institution.name
      }
    end
    mail(
      to: "#{recipient.full_name} <#{recipient.email}>",
      subject: t('mailers.system_loan_status_update_failed.subject', meta: subject_metadata)
    )
  end

  def loan_version_validated(loan_version_id)
    loan_version = LoanVersion.find(loan_version_id)
    @loan = loan_version.loan
    creation_user = loan_version.creation_user

    return unless creation_user.user_setting.allows_loans_validation_mail?

    @recipient_name = creation_user.full_name
    @noval = loan_version.loan.innpact_loan_id
    mail(
      to: "#{@recipient_name} <#{creation_user.email}>",
      subject: t('mailers.loan_version_validated.subject', meta: subject_metadata)
    )
  end

  def loan_version_rejected(loan_version_id)
    loan_version = LoanVersion.find(loan_version_id)
    @loan = loan_version.loan
    creation_user = loan_version.creation_user

    return unless creation_user.user_setting.allows_loans_validation_mail?

    @recipient_name = creation_user.full_name
    @noval = loan_version.loan.innpact_loan_id
    mail(
      to: "#{@recipient_name} <#{creation_user.email}>",
      subject: t('mailers.loan_version_rejected.subject', meta: subject_metadata)
    )
  end
end
