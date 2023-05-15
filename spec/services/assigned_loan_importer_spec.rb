require 'rails_helper'

RSpec.describe AssignedLoanImporter do
  let(:document_csv) do
    Rack::Test::UploadedFile.new(File.open(Rails.root.join('example_files', 'assigned_loan_import.csv')))
  end
  let(:document_xls) do
    Rack::Test::UploadedFile.new(File.open(Rails.root.join('example_files', 'assigned_loan_import.xls')))
  end
  let(:document_xlsx) do
    Rack::Test::UploadedFile.new(File.open(Rails.root.join('example_files', 'assigned_loan_import.xlsx')))
  end

  let!(:fund) { create(:fund) }
  let!(:currency) { create(:currency, short_name: 'EUR', fund: fund) }
  let!(:loan_type) { create(:loan_type, name: 'Renewal', fund: fund) }
  let!(:repayment_type) { create(:repayment_type, name: 'AMORTIZATION', fund: fund) }
  let!(:pool) { create(:pool, :targeted, name: 'Test', fund: fund) }

  let(:loan_attributes) do
    {
      currency_id: currency.id,
      loan_type_id: loan_type.id,
      pool_id: pool.id,
      nominal_amount: 2000.1,
      tenor: 2000.1,
      spread: 20.1,
      upfront_fees: 20.1,
      fixed_rate: 20.1,
      status_date: Date.new(2040, 10, 10),
      deadline_status_date: Date.new(2040, 10, 10),
      expected_disbursement_date: Date.new(2040, 10, 10),
      probabilities: 20.1,
      repayment_type_id: repayment_type.id
    }
  end

  it 'import attributes from file' do
    importer = AssignedLoanImporter.new(document_csv, fund)
    importer.process
    expect(importer.data_to_import).to eq(loan_attributes)
    expect(importer.errors).to be_empty
  end

  it 'import attributes from file' do
    importer = AssignedLoanImporter.new(document_xls, fund)
    importer.process
    expect(importer.data_to_import).to eq(loan_attributes)
    expect(importer.errors).to be_empty
  end

  it 'import attributes from file' do
    importer = AssignedLoanImporter.new(document_xlsx, fund)
    importer.process
    expect(importer.data_to_import).to eq(loan_attributes)
    expect(importer.errors).to be_empty
  end
end
