require 'rails_helper'

RSpec.describe Api::LoanValuesImportsController do
  let(:status_document_csv) do
    Rack::Test::UploadedFile.new(File.open(Rails.root.join('example_files', 'loan_status_data.csv')))
  end
  let(:status_document_xls) do
    Rack::Test::UploadedFile.new(File.open(Rails.root.join('example_files', 'loan_status_data.xls')))
  end
  let(:status_document_xlsx) do
    Rack::Test::UploadedFile.new(File.open(Rails.root.join('example_files', 'loan_status_data.xlsx')))
  end
  let(:invalid_document) do
    Rack::Test::UploadedFile.new(File.open(Rails.root.join('example_files', 'empty_file.pdf')))
  end
  let(:assigned_loan_document_csv) do
    Rack::Test::UploadedFile.new(File.open(Rails.root.join('example_files', 'assigned_loan_import.csv')))
  end
  let(:assigned_loan_document_xls) do
    Rack::Test::UploadedFile.new(File.open(Rails.root.join('example_files', 'assigned_loan_import.xls')))
  end
  let(:assigned_loan_document_xlsx) do
    Rack::Test::UploadedFile.new(File.open(Rails.root.join('example_files', 'assigned_loan_import.xlsx')))
  end
  let(:invested_status_document_csv) do
    Rack::Test::UploadedFile.new(File.open(Rails.root.join('example_files', 'invested_status_data.csv')))
  end
  let(:invested_status_document_xls) do
    Rack::Test::UploadedFile.new(File.open(Rails.root.join('example_files', 'invested_status_data.xls')))
  end
  let(:invested_status_document_xlsx) do
    Rack::Test::UploadedFile.new(File.open(Rails.root.join('example_files', 'invested_status_data.xlsx')))
  end

  let!(:fund) { create(:fund) }
  let!(:currency) { create(:currency, short_name: 'EUR', fund: fund) }
  let!(:loan_type) { create(:loan_type, name: 'Renewal', fund: fund) }
  let!(:repayment_type) { create(:repayment_type, name: 'AMORTIZATION', fund: fund) }
  let!(:bond) { create(:bond, name: 'Dummy bond', fund: fund) }
  let!(:interest_rate_type) { create(:interest_rate_type, name: 'Dummy Interest Rate Type', fund: fund) }
  let!(:pool) { create(:pool, :targeted, name: 'Test', fund: fund) }

  describe 'get values from loan status file' do
    it 'get values from a valid csv file' do
      post '/api/loan_values_imports', params: {
        mode: 'status',
        fund_id: fund.id,
        file: status_document_csv
      }

      expect(response).to have_http_status(:ok)

      body = response.parsed_body

      expect(body['data_to_import']['nominal_amount']).to eq(222.2)
      expect(body['data_to_import']['tenor']).to eq(333.3)
      expect(body['data_to_import']['spread']).to eq(11.1)
      expect(body['data_to_import']['upfront_fees']).to eq(22.2)
      expect(body['data_to_import']['fixed_rate']).to eq(33.3)
      expect(body['data_to_import']['status_date']).to eq('2030-12-24')
      expect(body['data_to_import']['deadline_status_date']).to eq('2030-12-31')
    end

    it 'imports a valid xls file' do
      post '/api/loan_values_imports', params: {
        mode: 'status',
        fund_id: fund.id,
        file: status_document_xls
      }

      expect(response).to have_http_status(:ok)

      body = response.parsed_body

      expect(body['data_to_import']['nominal_amount']).to eq(222.2)
      expect(body['data_to_import']['tenor']).to eq(333.3)
      expect(body['data_to_import']['spread']).to eq(11.1)
      expect(body['data_to_import']['upfront_fees']).to eq(22.2)
      expect(body['data_to_import']['fixed_rate']).to eq(33.3)
      expect(body['data_to_import']['status_date']).to eq('2030-12-24')
      expect(body['data_to_import']['deadline_status_date']).to eq('2030-12-31')
    end

    it 'imports a valid xlsx file' do
      post '/api/loan_values_imports', params: {
        mode: 'status',
        fund_id: fund.id,
        file: status_document_xlsx
      }

      expect(response).to have_http_status(:ok)

      body = response.parsed_body

      expect(body['data_to_import']['nominal_amount']).to eq(222.2)
      expect(body['data_to_import']['tenor']).to eq(333.3)
      expect(body['data_to_import']['spread']).to eq(11.1)
      expect(body['data_to_import']['upfront_fees']).to eq(22.2)
      expect(body['data_to_import']['fixed_rate']).to eq(33.3)
      expect(body['data_to_import']['status_date']).to eq('2030-12-24')
      expect(body['data_to_import']['deadline_status_date']).to eq('2030-12-31')
    end

    it 'imports a invalid file' do
      post '/api/loan_values_imports', params: {
        mode: 'status',
        fund_id: fund.id,
        file: invalid_document
      }

      expect(response).to have_http_status(:bad_request)
    end
  end

  describe 'get values from invested loan status file' do
    it 'get values from a valid csv file' do
      post '/api/loan_values_imports', params: {
        mode: 'status',
        fund_id: fund.id,
        file: invested_status_document_csv
      }

      expect(response).to have_http_status(:ok)

      body = response.parsed_body
      expect(body['data_to_import']['nominal_amount']).to eq(222.2)
      expect(body['data_to_import']['tenor']).to eq(333.3)
      expect(body['data_to_import']['spread']).to eq(11.1)
      expect(body['data_to_import']['upfront_fees']).to eq(22.2)
      expect(body['data_to_import']['fixed_rate']).to eq(33.3)
      expect(body['data_to_import']['disbursment_date']).to eq('2030-12-24')
      expect(body['data_to_import']['maturity_date']).to eq('2030-12-31')
      expect(body['data_to_import']['bond']).to eq(bond.id)
      expect(body['data_to_import']['interest_rate_type']).to eq(interest_rate_type.id)
    end

    it 'imports a valid xls file' do
      post '/api/loan_values_imports', params: {
        mode: 'status',
        fund_id: fund.id,
        file: invested_status_document_xls
      }

      expect(response).to have_http_status(:ok)

      body = response.parsed_body

      expect(body['data_to_import']['nominal_amount']).to eq(222.2)
      expect(body['data_to_import']['tenor']).to eq(333.3)
      expect(body['data_to_import']['spread']).to eq(11.1)
      expect(body['data_to_import']['upfront_fees']).to eq(22.2)
      expect(body['data_to_import']['fixed_rate']).to eq(33.3)
      expect(body['data_to_import']['disbursment_date']).to eq('2030-12-24')
      expect(body['data_to_import']['maturity_date']).to eq('2030-12-31')
      expect(body['data_to_import']['bond']).to eq(bond.id)
      expect(body['data_to_import']['interest_rate_type']).to eq(interest_rate_type.id)
    end

    it 'imports a valid xlsx file' do
      post '/api/loan_values_imports', params: {
        mode: 'status',
        fund_id: fund.id,
        file: invested_status_document_xlsx
      }

      expect(response).to have_http_status(:ok)

      body = response.parsed_body

      expect(body['data_to_import']['nominal_amount']).to eq(222.2)
      expect(body['data_to_import']['tenor']).to eq(333.3)
      expect(body['data_to_import']['spread']).to eq(11.1)
      expect(body['data_to_import']['upfront_fees']).to eq(22.2)
      expect(body['data_to_import']['fixed_rate']).to eq(33.3)
      expect(body['data_to_import']['disbursment_date']).to eq('2030-12-24')
      expect(body['data_to_import']['maturity_date']).to eq('2030-12-31')
      expect(body['data_to_import']['bond']).to eq(bond.id)
      expect(body['data_to_import']['interest_rate_type']).to eq(interest_rate_type.id)
    end

    it 'imports a invalid file' do
      post '/api/loan_values_imports', params: {
        mode: 'status',
        fund_id: fund.id,
        file: invalid_document
      }

      expect(response).to have_http_status(:bad_request)
    end
  end

  describe 'get values from assigned loan file' do
    it 'get values from a valid csv file' do
      post '/api/loan_values_imports', params: {
        mode: 'assigned_loan',
        file: assigned_loan_document_csv,
        fund_id: fund.id
      }

      expect(response).to have_http_status(:ok)

      body = response.parsed_body

      expect(body['data_to_import']['nominal_amount']).to eq(2000.1)
      expect(body['data_to_import']['tenor']).to eq(2000.1)
      expect(body['data_to_import']['spread']).to eq(20.1)
      expect(body['data_to_import']['upfront_fees']).to eq(20.1)
      expect(body['data_to_import']['fixed_rate']).to eq(20.1)
      expect(body['data_to_import']['status_date']).to eq('2040-10-10')
      expect(body['data_to_import']['deadline_status_date']).to eq('2040-10-10')
      expect(body['data_to_import']['expected_disbursement_date']).to eq('2040-10-10')
      expect(body['data_to_import']['currency_id']).to eq(currency.id)
      expect(body['data_to_import']['loan_type_id']).to eq(loan_type.id)
      expect(body['data_to_import']['repayment_type_id']).to eq(repayment_type.id)
      expect(body['data_to_import']['probabilities']).to eq(20.1)
      expect(body['data_to_import']['pool_id']).to eq(pool.id)
    end

    it 'imports a valid xls file' do
      post '/api/loan_values_imports', params: {
        mode: 'assigned_loan',
        file: assigned_loan_document_xls,
        fund_id: fund.id
      }

      expect(response).to have_http_status(:ok)

      body = response.parsed_body

      expect(body['data_to_import']['nominal_amount']).to eq(2000.1)
      expect(body['data_to_import']['tenor']).to eq(2000.1)
      expect(body['data_to_import']['spread']).to eq(20.1)
      expect(body['data_to_import']['upfront_fees']).to eq(20.1)
      expect(body['data_to_import']['fixed_rate']).to eq(20.1)
      expect(body['data_to_import']['status_date']).to eq('2040-10-10')
      expect(body['data_to_import']['deadline_status_date']).to eq('2040-10-10')
      expect(body['data_to_import']['deadline_status_date']).to eq('2040-10-10')
      expect(body['data_to_import']['expected_disbursement_date']).to eq('2040-10-10')
      expect(body['data_to_import']['currency_id']).to eq(currency.id)
      expect(body['data_to_import']['loan_type_id']).to eq(loan_type.id)
      expect(body['data_to_import']['repayment_type_id']).to eq(repayment_type.id)
      expect(body['data_to_import']['probabilities']).to eq(20.1)
      expect(body['data_to_import']['pool_id']).to eq(pool.id)
    end

    it 'imports a valid xlsx file' do
      post '/api/loan_values_imports', params: {
        mode: 'assigned_loan',
        file: assigned_loan_document_xlsx,
        fund_id: fund.id
      }

      expect(response).to have_http_status(:ok)

      body = response.parsed_body

      expect(body['data_to_import']['nominal_amount']).to eq(2000.1)
      expect(body['data_to_import']['tenor']).to eq(2000.1)
      expect(body['data_to_import']['spread']).to eq(20.1)
      expect(body['data_to_import']['upfront_fees']).to eq(20.1)
      expect(body['data_to_import']['fixed_rate']).to eq(20.1)
      expect(body['data_to_import']['status_date']).to eq('2040-10-10')
      expect(body['data_to_import']['deadline_status_date']).to eq('2040-10-10')
      expect(body['data_to_import']['expected_disbursement_date']).to eq('2040-10-10')
      expect(body['data_to_import']['currency_id']).to eq(currency.id)
      expect(body['data_to_import']['loan_type_id']).to eq(loan_type.id)
      expect(body['data_to_import']['repayment_type_id']).to eq(repayment_type.id)
      expect(body['data_to_import']['probabilities']).to eq(20.1)
      expect(body['data_to_import']['pool_id']).to eq(pool.id)
    end

    it 'imports a invalid file' do
      post '/api/loan_values_imports', params: {
        mode: 'assigned_loan',
        file: invalid_document,
        fund_id: fund.id
      }

      expect(response).to have_http_status(:bad_request)
    end
  end
end
