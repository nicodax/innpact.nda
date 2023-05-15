# frozen_string_literal: true

class ArchiveMailer < ApplicationMailer
  def system_archive_failed(not_processed_value_by_archive, recipient)
    @not_processed_value_by_archive = not_processed_value_by_archive
    mail(
      to: "#{recipient.full_name} <#{recipient.email}>",
      subject: t('mailers.system_archive_failed.subject', meta: subject_metadata)
    )
  end
end
