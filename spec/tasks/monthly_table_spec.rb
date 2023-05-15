# frozen_string_literal: true

# rubocop:disable RSpec/DescribeClass

require 'rails_helper'

Rails.application.load_tasks

RSpec.describe 'monthly_table:create task validation' do
  include_context 'shared factories'

  let!(:loan) do
    create(:loan, institution_id: institution.id, im_group: default_im_group,
                  innpact_loan_id: rand(1000), last_loan_version: 2, fund: fund,
                  creation_user: investment_manager)
  end
  let(:loan_version1) do
    create(:loan_version, :assigned, loan: loan,
                                     version_status: LoanVersion::VERSION_STATUS_VALIDATED,
                                     version_number: 1, validation_user: administrator,
                                     creation_user: investment_manager)
  end
  let(:loan_version2) do
    create(:loan_version, :ratified, loan: loan,
                                     version_status: LoanVersion::VERSION_STATUS_TEMPORARY,
                                     version_number: 2, creation_user: investment_manager)
  end

  sql_value_v_loans = %(
        SELECT * FROM v_loans;
      )
  sql_value_cash_flows = %(
    SELECT * FROM cash_flows;
    )
  sql_value_v_institutions = %(
    SELECT * FROM v_institutions;
    )
  sql_value_v_institutions_covenants = %(
    SELECT * FROM v_institutions_covenants;
    )

  def execute_statement(sql)
    ActiveRecord::Base.connection.exec_query(sql)
  end

  it 'validates the monthly_table:create task completed successfuly with all the variables present in the report' do
    expect { Rake::Task['monthly_table:create'].execute }.not_to raise_error
  end

  it 'verify the archive_v_loans got all the columns from v_loans_view' do
    archive_columns = ArchiveVLoan.columns.map(&:name)
    view_values = execute_statement(sql_value_v_loans)
    expect(archive_columns).to include(*view_values.columns),
                               "This values are missing in the archive_v_loans table #{view_values.columns - archive_columns}"
  end

  it 'verify the archive_cash_flows got all the columns from cash_flows_view' do
    archive_columns = ArchiveCashFlow.columns.map(&:name)
    view_values = execute_statement(sql_value_cash_flows)
    expect(archive_columns).to include(*view_values.columns),
                               "This values are missing in the archive_cash_flows table #{view_values.columns - archive_columns}"
  end

  it 'verify the archive_v_institutions got all the columns from v_loans_view' do
    archive_columns = ArchiveVInstitution.columns.map(&:name)
    view_values = execute_statement(sql_value_v_institutions)
    expect(archive_columns).to include(*view_values.columns),
                               "This values are missing in the archive_v_institutions table #{view_values.columns - archive_columns}"
  end

  it 'verify the archive_v_institutions_covenants got all the columns from cash_flows_view' do
    archive_columns = ArchiveVInstitutionsCovenant.columns.map(&:name)
    view_values = execute_statement(sql_value_v_institutions_covenants)
    expect(archive_columns).to include(*view_values.columns),
                               "This values are missing in the archive_v_institutions_covenants table #{view_values.columns - archive_columns}"
  end
end

# rubocop:enable RSpec/DescribeClass
