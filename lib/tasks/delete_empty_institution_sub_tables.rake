# frozen_string_literal: true

require 'logger'

namespace :delete_empty_institution_sub_tables do
  desc 'Go through all the institution sub tables and delete any rows with only the as_of date present.'
  task delete: :environment do
    logger = Logger.new('./log/tasks.log')
    logger.info 'Starting delete_empty_institution_sub_tables task'

    tables = %w[institution_esg_pai_indicators institution_esg_risks institution_ratings institution_financials
                institution_specific_breakdowns institution_impact_indicators positive_impact_services_offereds
                institution_esg_gender_equalities institution_alinus_results institution_esg_safeguards
                additional_pais_environments additional_pais_socials]
    rejected_common_columns_name = %w[id created_at updated_at as_of institution_id user_id]
    numeric_column_type = %i[integer float decimal]

    # start the transaction
    ActiveRecord::Base.transaction do
      # loop through all the tables
      tables.each do |table_name|
        # get all the column names except for rejected_common_columns_name divided into numeric and not numeric
        column_names_not_numeric = ActiveRecord::Base.connection.columns(table_name)
                                                     .reject { |column| rejected_common_columns_name.include?(column.name) || numeric_column_type.include?(column.type) }
                                                     .map(&:name)

        column_names_numeric = ActiveRecord::Base.connection.columns(table_name)
                                                 .reject { |column| rejected_common_columns_name.include?(column.name) || numeric_column_type.exclude?(column.type) }
                                                 .map(&:name)
        # filter the rows with the column values null or empty (not numeric columns only)
        model = table_name.classify.constantize
        model_data_not_numeric_all_null_empty = model.where(column_names_not_numeric.map { |column_name| "(#{column_name} IS NULL OR #{column_name} = '' )" }.join(' AND '))
        model_data_numeric_all_null_empty = model.where(column_names_numeric.map { |column_name| "( #{column_name} IS NULL )" }.join(' AND '))
        model_data_to_delete = if column_names_not_numeric.empty?
                                 model_data_numeric_all_null_empty
                               elsif column_names_numeric.empty?
                                 model_data_not_numeric_all_null_empty
                               else
                                 model_data_not_numeric_all_null_empty & model_data_numeric_all_null_empty
                               end
        number_of_rows_deleted = model_data_to_delete.count
        logger.info "Deleting #{number_of_rows_deleted} rows from #{table_name}"
        model_data_to_delete.each(&:delete)
      end
      logger.info 'Finished delete_empty_institution_sub_tables task'
    end
  end
end
