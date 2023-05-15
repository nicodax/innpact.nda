# frozen_string_literal: true

class AssignedLoanImporter < SpreadsheetFileImporter
  def initialize(file, fund)
    @file = file
    @fund = fund
    @data_to_import = {}
    @errors = []
  end

  def process()
    begin
      spreadsheet = open_spreadsheet(file)
      raise "File is empty" if check_for_empty_file(spreadsheet)

      header = spreadsheet.row(1)
      row = Hash[[header, spreadsheet.row(2)].transpose]
      @data_to_import = {
        currency_id: fund.currencies.where(short_name: row["Currency"]).first.try(:id),
        loan_type_id: fund.loan_types.where(name: row["Loan type"]).first.try(:id),
        pool_id: fund.pools.where(name: row["Pool"]).first.try(:id),
        nominal_amount: row["Nominal amount"].try(:to_f),
        tenor: row["Tenor"].try(:to_f),
        spread: row["Spread"].try(:to_f),
        upfront_fees: row["Upfront fees"].try(:to_f),
        fixed_rate: row["Fixed rate"].try(:to_f),
        status_date: row["Status date"].try(:to_date),
        deadline_status_date: row["Deadline status date"].try(:to_date),
        expected_disbursement_date: row["Expected disbursement date"].try(:to_date),
        probabilities: row["Probabilities"].try(:to_f),
        repayment_type_id: fund.repayment_types.where(name: row["Repayment type"]).first.try(:id)
      }
    rescue StandardError => e
      @errors = [e.message]
    end
  end

  attr_reader :errors, :fund
  attr_accessor :errors, :data_to_import

  private
end
