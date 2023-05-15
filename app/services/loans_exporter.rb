# frozen_string_literal: true

class LoansExporter
  def initialize(loans, loan_category)
    @loans = loans
    @loan_category = loan_category
  end

  def file_data
    csv_string = CSV.generate do |csv|
      csv << headers
      loans.each do |loan|
        csv << loan_line(loan)
      end
    end
    csv_string
  end

  private

  attr_reader :loans, :loan_category

  def headers
    loan_category == 'accepted' ?
      LoanDecorator.accepted_loans_columns_titles : LoanDecorator.not_accepted_loans_columns_titles
  end

  def loan_line(loan)
    loan_category == 'accepted' ?
      loan.accepted_loans_columns_values : loan.not_accepted_loans_columns_values
  end
end
