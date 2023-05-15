# frozen_string_literal: true

require 'roo'

class SpreadsheetFileImporter
  class EmptyImportFile < StandardError
    def initialize(message = 'Import file is empty.')
      super(message)
    end
  end

  class InvalidFileHeader < StandardError
    def initialize(message = 'Imported file has invalid header.')
      super(message)
    end
  end

  class FileNoExists < StandardError
    def initialize(message = 'You must upload file to start the import.')
      super(message)
    end
  end

  class FundNoExists < StandardError
    def initialize(message = 'You set fund to start the import.')
      super(message)
    end
  end

  class UserNoExists < StandardError
    def initialize(message = 'You set usert to start the import.')
      super(message)
    end
  end

  private

  attr_reader :file

  def valid_header?(header)
    file_header == header
  end

  def file_header
    raise 'Requires implementation'
  end

  def open_spreadsheet(file)
    case File.extname(file.original_filename)
    when '.csv' then Roo::CSV.new(file.path, csv_options: { encoding: 'iso-8859-1:utf-8', col_sep: "\t" })
    when '.xls' then Roo::Excel.new(file.path, excel_options: { encoding: 'iso-8859-1:utf-8' })
    when '.xlsx' then Roo::Excelx.new(file.path, excelx_options: { encoding: 'iso-8859-1:utf-8' })
    else raise "#{file.original_filename} : " + I18n.t('settings.currencies.upload.unknown_file')
    end
  end

  def check_for_empty_file(spreadsheet)
    return true if spreadsheet.first_row.nil?
  end
end
