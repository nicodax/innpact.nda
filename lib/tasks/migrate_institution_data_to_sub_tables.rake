# frozen_string_literal: true

require 'logger'

namespace :migrate_institution_data do
  desc 'Migrate institution data to sub tables'
  task migrate: :environment do
    # logger = Logger.new('./log/tasks.log')
    logger = Logger.new($stdout)
    logger.info('Start the migration of institution data to sub tables.')

    institution_sub_table_list = [
      InstitutionSpecificBreakdown,
      InstitutionImpactIndicator,
      InstitutionProfile,
      InstitutionRating,
      InstitutionFinancial,
      # InstitutionDistributionBySector,
      # InstitutionDistributionByLoanPurpose,
      InstitutionAlinusResult,
      PositiveImpactServicesOffered
    ]
    institution_sub_table_column_names = {
      InstitutionSpecificBreakdown => [],
      InstitutionImpactIndicator => [],
      InstitutionProfile => [],
      InstitutionRating => [],
      InstitutionFinancial => [],
      # InstitutionDistributionBySector => [],
      # From USD to %
      # InstitutionDistributionByLoanPurpose => [],
      InstitutionAlinusResult => [],
      PositiveImpactServicesOffered => []
    }

    ActiveRecord::Base.transaction do
      institution_sub_table_list.each do |institution_sub_table|
        institution_sub_table_column_names[institution_sub_table] = get_attributes_list(institution_sub_table)
      end

      all_institutions = Institution.all

      all_institutions.each do |institution|
        institution_sub_table_list.each do |sub_table|
          migrate_institution_sub_tables(institution, sub_table, institution_sub_table_column_names[sub_table])
        end
      end

      test_migration_went_well(institution_sub_table_list, all_institutions)

      logger.info('End the migration of institution data to sub tables.')
    end
  rescue StandardError => e
    logger.error(e.full_message)
  end

  def migrate_institution_sub_tables(institution_item, sub_table, attributes_from_sub_table)
    new_institution_sub_table = sub_table.new(
      institution_item.attributes.slice(*attributes_from_sub_table)
    )
    new_institution_sub_table.institution_id = institution_item.id
    new_institution_sub_table.as_of = get_correct_as_of_date_from_institution(institution_item, sub_table)
    new_institution_sub_table.user_id = User.system.first.id

    if sub_table == InstitutionSpecificBreakdown
      new_institution_sub_table.percentage_loans_to_rural_borrowers_per_glp =
        institution_item.percentage_rural_ptf
      new_institution_sub_table.by_sector_other = institution_item.other
    elsif sub_table == InstitutionRating
      new_institution_sub_table.internal_credit_risk_rating = institution_item.internal_rating
    end

    new_institution_sub_table.save!
  end

  def get_attributes_list(institution_sub_table)
    except_attributes = %w[id created_at updated_at deleted_at as_of institution_id user_id]
    institution_sub_table.column_names - except_attributes
  end

  def test_migration_went_well(institution_sub_table_list, all_institutions)
    institution_sub_table_list.each do |institution_sub_table|
      if institution_sub_table.all.count != all_institutions.count
        puts("Number of institutions in the database is not equal to the number of institutions in the new sub table #{institution_sub_table} after migration")
        raise StandardError.new "Number of institutions in the database is not equal to the number of institutions in the new sub table #{institution_sub_table} after migration"
      end
    end
    true
  end

  def get_correct_as_of_date_from_institution(institution_item, sub_table)
    institution_as_of_date_key_map = {
      InstitutionSpecificBreakdown => 'portfolio_breakdown_i_as_of_date',
      InstitutionImpactIndicator => 'clients_as_of_date',
      InstitutionProfile => 'general_as_of_date',
      InstitutionRating => 'general_rating_as_of_date',
      InstitutionFinancial => 'financials_as_of_date',
      InstitutionDistributionBySector => 'portfolio_breakdown_ii_as_of_date',
      InstitutionDistributionByLoanPurpose => 'portfolio_breakdown_iii_as_of_date',
      InstitutionAlinusResult => 'aptf_alinus_results_as_of_date'
    }
    as_of_value = institution_item[institution_as_of_date_key_map[sub_table]]
    as_of_value = as_of_value.to_date if !as_of_value.nil? && as_of_value.class != Date
    as_of_value.nil? ? institution_item.updated_at : as_of_value
  end
end
