# frozen_string_literal: true

namespace :monthly_table do
  logger = Logger.new('./log/cron.log')
  logger.formatter = Logger::Formatter.new

  desc 'Create monthly historic table for each view.'
  task create: :environment do
    logger.info('Monthly Archive started')
    sql_value_v_loans = %(
      SELECT * FROM v_loans;
    )
    sql_value_cash_flows = %(
      SELECT * FROM cash_flows;
    )
    sql_value_v_institutions = %(
      SELECT * FROM v_institutions;
    )
    sql_value_v_institutions_covenants = %(
      SELECT * FROM v_institutions_covenants;
    )
    sql_value_v_additional_pai_environments = %(
      SELECT * FROM v_additional_pai_environments;
    )
    sql_value_v_additional_pai_socials = %(
      SELECT * FROM v_additional_pai_socials;
    )

    not_processed_value_by_archive = {}
    not_processed_value_by_archive[:archive_v_loans] = archive_view(sql_value_v_loans, ArchiveVLoan)
    not_processed_value_by_archive[:archive_cash_flows] = archive_view(sql_value_cash_flows, ArchiveCashFlow)
    not_processed_value_by_archive[:archive_v_institutions] =
      archive_view(sql_value_v_institutions, ArchiveVInstitution)
    not_processed_value_by_archive[:archive_v_institutions_covenants] =
      archive_view(sql_value_v_institutions_covenants, ArchiveVInstitutionsCovenant)
    not_processed_value_by_archive[:archive_v_additional_pai_environments] =
      archive_view(sql_value_v_additional_pai_environments, ArchiveVAdditionalPaiEnvironment)
    not_processed_value_by_archive[:archive_v_additional_pai_socials] =
      archive_view(sql_value_v_additional_pai_socials, ArchiveVAdditionalPaiSocial)

    archive_error = ''
    archive_error += "These keys are missing in the archive_v_loans table: #{not_processed_value_by_archive[:archive_v_loans]} \n" unless not_processed_value_by_archive[:archive_v_loans].empty?
    archive_error += "These keys are missing in the archive_cash_flows table: #{not_processed_value_by_archive[:archive_cash_flows]} \n" unless not_processed_value_by_archive[:archive_cash_flows].empty?
    archive_error += "These keys are missing in the archive_v_institutions table: #{not_processed_value_by_archive[:archive_v_institutions]} \n" unless not_processed_value_by_archive[:archive_v_institutions].empty?
    archive_error += "These keys are missing in the archive_v_institutions_covenants table: #{not_processed_value_by_archive[:archive_v_institutions_covenants]} \n" unless not_processed_value_by_archive[:archive_v_institutions_covenants].empty?
    archive_error += "These keys are missing in the archive_v_additional_pai_environments table: #{not_processed_value_by_archive[:archive_v_additional_pai_environments]} \n" unless not_processed_value_by_archive[:archive_v_additional_pai_environments].empty?
    archive_error += "These keys are missing in the archive_v_additional_pai_socials table: #{not_processed_value_by_archive[:archive_v_additional_pai_socials]} \n" unless not_processed_value_by_archive[:archive_v_additional_pai_socials].empty?

    # unless archive_error is not an empty string send the email to the admins and gms.
    unless archive_error.empty?
      logger.info("Monthly Archive skipped columns because keys were missing in the archive table: #{archive_error}")
      send_archive_fail_summary_email_to_admins_and_gms(not_processed_value_by_archive)
    end
    logger.info('Monthly Archive ended')
  end

  def archive_view(sql_value, archive_name)
    archive_columns = archive_name.columns.map(&:name)
    view_values = execute_statement(sql_value)
    not_processed_value = []
    if view_values.present?
      view_values.each do |row|
        next if row.blank?

        new_row = {}
        row.each do |key, value|
          if archive_columns.include? key
            new_row[key] = value
          else
            not_processed_value << key
          end
        end
        archive_name.create(new_row)
      end
    end
    not_processed_value.uniq
  end

  def execute_statement(sql)
    results = ActiveRecord::Base.connection.exec_query(sql)
    results.presence
  end

  def send_archive_fail_summary_email_to_admins_and_gms(not_processed_value_by_archive)
    return if not_processed_value_by_archive.empty?

    managers = User.with_any_role(User::ROLE_ADMINISTRATOR, User::ROLE_GENERAL_MANAGER)
    managers.each do |manager|
      ArchiveMailer.system_archive_failed(not_processed_value_by_archive, manager).deliver_now
    end
  end
end
