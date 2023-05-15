# frozen_string_literal: true

class RepaymentCalendarMailer < ApplicationMailer
  def repayment_calendar_update_without_validation_link(repayment_calendar_id, recipient)
    return unless recipient.user_setting.allows_repayments_crud_mail?

    @repayment_calendar = RepaymentCalendar.includes(loan_version: { loan: :institution })
                                           .find(repayment_calendar_id)
    @investment_manager_name = recipient.full_name
    @noval = repayment_calendar.loan.innpact_loan_id
    @mfi_name = repayment_calendar.loan.institution.name
    @loan_id = repayment_calendar.loan.id
    @fund_id = repayment_calendar.loan.fund_id

    mail(
      to: "#{recipient.full_name} <#{recipient.email}>",
      subject: t('mailers.mail_repayment_calendar_update.subject', meta: subject_metadata)
    )
  end

  def repayment_calendar_update_with_validation_link(repayment_calendar_id, recipient)
    return unless recipient.user_setting.allows_repayments_validation_mail?

    @repayment_calendar = RepaymentCalendar.includes(:creation_user, loan_version: { loan: :institution })
                                           .find(repayment_calendar_id)
    @loan_version_id = repayment_calendar.loan_version_id
    @creation_user_name = repayment_calendar.creation_user.full_name
    @noval = repayment_calendar.loan.innpact_loan_id
    @mfi_name = repayment_calendar.loan.institution.name
    @loan_id = repayment_calendar.loan.id
    @fund_id = repayment_calendar.loan.fund_id

    mail(
      to: "#{recipient.full_name} <#{recipient.email}>",
      subject: t('mailers.investment_manager_repayment_calendar_update.subject', meta: subject_metadata)
    )
  end

  def repayment_calendar_validated(repayment_calendar_id)
    repayment_calendar = RepaymentCalendar.includes(:creation_user, loan_version: { loan: :institution })
                                          .find(repayment_calendar_id)
    @loan = repayment_calendar.loan
    creation_user = repayment_calendar.creation_user

    return unless creation_user.user_setting.allows_repayments_validation_mail?

    @recipient_name = creation_user.full_name
    @noval = repayment_calendar.loan.innpact_loan_id
    mail(
      to: "#{@recipient_name} <#{creation_user.email}>",
      subject: t('mailers.repayment_calendar_validated.subject', meta: subject_metadata)
    )
  end

  def repayment_calendar_rejected(repayment_calendar_id)
    repayment_calendar = RepaymentCalendar.includes(:creation_user, loan_version: { loan: :institution })
                                          .find(repayment_calendar_id)
    @loan = repayment_calendar.loan
    creation_user = repayment_calendar.creation_user

    return unless creation_user.user_setting.allows_repayments_validation_mail?

    @recipient_name = creation_user.full_name
    @noval = repayment_calendar.loan.innpact_loan_id
    mail(
      to: "#{@recipient_name} <#{creation_user.email}>",
      subject: t('mailers.repayment_calendar_rejected.subject', meta: subject_metadata)
    )
  end

  attr_reader :repayment_calendar
end
