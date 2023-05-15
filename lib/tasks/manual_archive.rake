# frozen_string_literal: true

namespace :manual_archive do
  logger = Logger.new('./log/cron.log')
  logger.formatter = Logger::Formatter.new

  desc 'Create monthly historic table for each view.'
  task create: :environment do
    date_of_today = "#{Time.zone.today.strftime('%d_%m_%Y')}_#{Time.zone.now.strftime('%H%M%S')}"

    create_new_archive_v_loan_table_hot_fix = %(
      SELECT  *
      INTO    [dbo].[archive_v_loans_#{date_of_today}]
      FROM    [dbo].[v_loans]
    )

    create_new_archive_cash_flows_table_hot_fix = %(
      SELECT  *
      INTO    [dbo].[archive_cash_flows_#{date_of_today}]
      FROM    [dbo].[cash_flows]
    )

    create_new_archive_v_institutions_table_hot_fix = %(
      SELECT  *
      INTO    [dbo].[archive_v_institutions_#{date_of_today}]
      FROM    [dbo].[v_institutions]
    )

    create_new_archive_v_institutions_covenants_table_hot_fix = %(
      SELECT  *
      INTO    [dbo].[archive_v_institutions_covenants_#{date_of_today}]
      FROM    [dbo].[v_institutions_covenants]
    )

    create_new_archive_v_additional_pai_environments_table_hot_fix = %(
      SELECT  *
      INTO    [dbo].[archive_v_additional_pai_environments_#{date_of_today}]
      FROM    [dbo].[v_additional_pai_environments]
    )

    create_new_archive_v_additional_pai_socials_table_hot_fix = %(
      SELECT  *
      INTO    [dbo].[archive_v_additional_pai_socials_#{date_of_today}]
      FROM    [dbo].[v_additional_pai_socials]
    )

    execute_statement(create_new_archive_v_loan_table_hot_fix)
    logger.info("Manual archive created table archive_v_loans_#{date_of_today}.")
    execute_statement(create_new_archive_cash_flows_table_hot_fix)
    logger.info("Manual archive created table archive_cash_flows_#{date_of_today}.")
    execute_statement(create_new_archive_v_institutions_table_hot_fix)
    logger.info("Manual archive created table archive_v_institutions_#{date_of_today}.")
    execute_statement(create_new_archive_v_institutions_covenants_table_hot_fix)
    logger.info("Manual archive created table archive_v_institutions_covenants_#{date_of_today}.")
    execute_statement(create_new_archive_v_additional_pai_environments_table_hot_fix)
    logger.info("Manual archive created table archive_v_additional_pai_environments#{date_of_today}.")
    execute_statement(create_new_archive_v_additional_pai_socials_table_hot_fix)
    logger.info("Manual archive created table archive_v_additional_pai_socials#{date_of_today}.")
    logger.info('Manual archive rake task done.')
  end

  def execute_statement(sql)
    results = ActiveRecord::Base.connection.exec_query(sql)
    results.presence
  end
end
