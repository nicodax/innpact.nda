# frozen_string_literal: true

class InstitutionCovenantsImporter < SpreadsheetFileImporter
  ImportResult = Struct.new(:errors, :success, :total_count, :imported_count, :rejected_count, keyword_init: true)

  BATCH_SIZE = 50

  FILE_HEADER = [
    'Name',
    'PAR30',
    'PAR30 Limit',
    'PAR30 + refy',
    'PAR30 + refy Limit',
    'ROA',
    'ROA Limit',
    'Adj ROA',
    'Adj ROA Limit',
    'Open FX exposure',
    'Open FX exposure Limit',
    'Open loan position',
    'Open loan position Limit',
    'CAR',
    'CAR Limit',
    'Deposits/ Liabilities',
    'Deposits/ Liabilities Limit',
    'Maturity Matching if applicable',
    'Maturity Matching if applicable Limit',
    'Liquid assets/ deposits if applicable',
    'Liquid assets/ deposits if applicable Limit'
  ].freeze

  def self.import_file(fund:, file:, current_user:, institutions:)
    service = new
    service.process(fund: fund, file: file, current_user: current_user, institutions: institutions)
  end

  def initialize
    super
    @entries = {}
    @result = ImportResult.new(errors: [], success: [], total_count: 0, imported_count: 0, rejected_count: 0)
  end

  def process(fund:, file:, current_user:, institutions:)
    validate!(fund: fund, file: file, current_user: current_user)

    spreadsheet = open_spreadsheet(file)
    raise EmptyImportFile if check_for_empty_file(spreadsheet)

    header = spreadsheet.row(1)
    raise InvalidFileHeader unless valid_header?(header)

    (2..spreadsheet.last_row).each_with_index do |raw_data, index|
      row = Hash[[header, spreadsheet.row(raw_data)].transpose]
      institution_name = row.delete('Name').strip
      @entries[institution_name] = row

      if index.positive? && (index % BATCH_SIZE).zero?
        process_entries(fund: fund, current_user: current_user, institutions: institutions)
      end
    end
    process_entries(fund: fund, current_user: current_user, institutions: institutions)

    @result
  end

  # This method doesn't work with "30.5%"
  def convert_value(value)
    value = value.delete('%').to_d / 100 if value.is_a?(String) && value.include?('%')
    value * BigDecimal(100)
  rescue StandardError
    nil
  end

  private

  def validate!(fund:, file:, current_user:)
    raise FundNoExists unless fund.present?
    raise FileNoExists unless file.present?
    raise UserNoExists unless current_user.present?
  end

  def file_header
    FILE_HEADER
  end

  def process_entries(fund:, current_user:, institutions:)
    batch_names = @entries.keys
    fund.institution_covenants.transaction do
      institutions.includes(:institution_covenant).where('trim(name) IN (?)', batch_names).each do |institution|
        covenant = find_or_initialize_covenant(institution: institution, fund: fund)
        entry_institution = @entries[institution.name.strip]
        next if entry_institution.blank?

        covenant.attributes = build_attributes(covenant: covenant, row: entry_institution)

        unless covenant.valid?
          @result.errors.push({ name: institution.name, institution_id: institution.id,
                                errors: covenant.errors.full_messages })
          @result.rejected_count += 1
          next
        end

        covenant.save
        @result.success.push({ name: institution.name, institution_id: institution.id, covenant_id: covenant.id })
        @result.imported_count += 1
      end
    end

    @result.total_count += batch_names.size
    @entries = {}
  end

  def build_attributes(covenant:, row:)
    row.each { |key, val| row[key] = convert_value(val) }

    {
      id: covenant&.id,
      par30: row['PAR30'],
      par30_limit: row['PAR30 Limit'],
      par30_refy: row['PAR30 + refy'],
      par30_refy_limit: row['PAR30 + refy Limit'],
      roa: row['ROA'],
      roa_limit: row['ROA Limit'],
      adj_roa: row['Adj ROA'],
      adj_roa_limit: row['Adj ROA Limit'],
      open_fx_exposure: row['Open FX exposure'],
      open_fx_exposure_limit: row['Open FX exposure Limit'],
      open_loan_position: row['Open loan position'],
      open_loan_position_limit: row['Open loan position Limit'],
      car: row['CAR'],
      car_limit: row['CAR Limit'],
      deposits_liabilities: row['Deposits/ Liabilities'],
      deposits_liabilities_limit: row['Deposits/ Liabilities Limit'],
      maturity_matching_if_applicable: row['Maturity Matching if applicable'],
      maturity_matching_if_applicable_limit: row['Maturity Matching if applicable Limit'],
      liquid_assets_deposits_if_applicable: row['Liquid assets/ deposits if applicable'],
      liquid_assets_deposits_if_applicable_limit: row['Liquid assets/ deposits if applicable Limit']
    }
  end

  def find_or_initialize_covenant(fund:, institution:)
    institution.institution_covenant || InstitutionCovenant.new(fund_id: fund.id, institution_id: institution.id)
  end
end
