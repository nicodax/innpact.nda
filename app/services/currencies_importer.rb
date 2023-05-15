# frozen_string_literal: true

class CurrenciesImporter < SpreadsheetFileImporter
  FILE_HEADER = %w[CCY RATE].freeze

  def self.import_file(file, current_user, fund)
    service = new(file)
    service.process(current_user, fund)
  end

  def initialize(file)
    @file = file
  end

  def process(current_user, fund)
    spreadsheet = open_spreadsheet(file)
    raise EmptyImportFile if check_for_empty_file(spreadsheet)

    header = spreadsheet.row(1)
    raise InvalidFileHeader unless valid_header?(header)

    (2..spreadsheet.last_row).each do |raw_data|
      row = Hash[[header, spreadsheet.row(raw_data)].transpose]
      process_row(row: row, current_user: current_user, fund: fund)
    end
  end

  private

  def file_header
    FILE_HEADER
  end

  def process_row(row:, current_user:, fund:)
    currency = fund.currencies.find_or_create_by(short_name: row['CCY'].strip)
    return if currency.deleted?

    currency.currency_rates.create(rate: row['RATE'], created_by: current_user.full_name)
  end
end
