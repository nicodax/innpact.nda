# frozen_string_literal: true

class LoanStatusDataImporter < SpreadsheetFileImporter
  def initialize(file, fund)
    @file = file
    @fund = fund
    @data_to_import = {}
    @errors = []
  end

  def process
    spreadsheet = open_spreadsheet(file)
    raise EmptyImportFile if check_for_empty_file(spreadsheet)

    header = spreadsheet.row(1)
    row = Hash[[header, spreadsheet.row(2)].transpose]

    @data_to_import = {
      nominal_amount: row['Nominal amount'].try(:to_f),
      tenor: row['Tenor'].try(:to_f),
      spread: row['Spread'].try(:to_f),
      upfront_fees: row['Upfront fees'].try(:to_f),
      fixed_rate: row['Fixed rate'].try(:to_f),
      status_date: row['Status date'].try(:to_date),
      deadline_status_date: row['Deadline status date'].try(:to_date),
      disbursment_date: row['Disbursment date'].try(:to_date),
      maturity_date: row['Maturity date'].try(:to_date),
      bond: fund.bonds.where(name: row['Bond']).first.try(:id),
      interest_rate_type: fund.interest_rate_types.where(name: row['Interest rate type']).first.try(:id),
      invested_hedge: row['Invested hedge'],
      status_comment: row['Comment']
    }
  rescue StandardError => e
    @errors = [e.message]
  end

  attr_reader :errors, :fund
  attr_accessor :data_to_import
end
