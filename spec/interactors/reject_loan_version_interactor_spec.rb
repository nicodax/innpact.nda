# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RejectLoanVersionInteractor do
  include_context 'shared factories'

  let!(:currency_1) { create(:currency, fund: fund) }
  let!(:pool) { create(:pool, :targeted, fund: fund) }
  let!(:loan_type_1) { create(:loan_type, fund: fund) }
  let!(:repayment_type_1) { create(:repayment_type, fund: fund) }

  let!(:loan) do
    create(:loan, institution_id: institution.id, im_group: default_im_group,
                  innpact_loan_id: rand(1000), last_loan_version: 2, fund: fund,
                  creation_user: investment_manager)
  end
  let!(:loan_version_assigned) do
    create(:loan_version, :assigned, loan: loan,
                                     version_status: LoanVersion::VERSION_STATUS_VALIDATED,
                                     version_number: 1, validation_user: administrator,
                                     creation_user: investment_manager)
  end
  let!(:loan_version_ratified) do
    create(:loan_version, :ratified, loan: loan,
                                     version_status: LoanVersion::VERSION_STATUS_TEMPORARY,
                                     version_number: 2, creation_user: investment_manager)
  end

  let!(:invested_loan) do
    create(:loan, institution_id: institution.id, im_group: default_im_group,
                  innpact_loan_id: rand(1000), last_loan_version: 2, fund: fund,
                  creation_user: investment_manager)
  end
  let!(:invested_loan_version_approved) do
    create(:loan_version, :approved, loan: invested_loan,
                                     version_status: LoanVersion::VERSION_STATUS_VALIDATED,
                                     version_number: 1, validation_user: administrator,
                                     creation_user: investment_manager)
  end
  let!(:invested_loan_version_invested) do
    create(:loan_version, :invested, loan: invested_loan,
                                     version_status: LoanVersion::VERSION_STATUS_TEMPORARY,
                                     version_number: 2, creation_user: investment_manager,
                                     executed_nominal_amount: 100)
  end
  let(:repayment_calendar_line) { build(:repayment_calendar_line, original_amount: 100) }
  let!(:invested_repayment_calendar) do
    create(:repayment_calendar, loan_version: invested_loan_version_invested,
                                version_status: RepaymentCalendar::VERSION_STATUS_TEMPORARY,
                                creation_user: investment_manager,
                                repayment_calendar_lines: [repayment_calendar_line])
  end
  let!(:calendar_log) do
    create(:calendar_log, repayment_calendar: invested_repayment_calendar, creation_user: investment_manager)
  end

  it 'rejects a loan version' do
    context = RejectLoanVersionInteractor.call(loan_version: loan_version_ratified, user: administrator,
                                               validation_object: 'version')
    expect(context).to be_success

    new_loan = loan.reload
    rejected_loan_version = LoanVersion.find(loan_version_ratified.id)
    expect(rejected_loan_version.version_status).to eq(LoanVersion::VERSION_STATUS_REJECTED)
    expect(rejected_loan_version.rejection_user).to eq(administrator)
    new_loan_version = new_loan.active_loan_version
    expect(new_loan_version.status).to eq(LoanVersion::STATUS_ASSIGNED)
    expect(new_loan_version.version_status).to eq(LoanVersion::VERSION_STATUS_VALIDATED)
    expect(new_loan_version.validation_user).to eq(administrator)
    expect(new_loan_version.creation_user).to eq(administrator)

    email = ActionMailer::Base.deliveries.first
    expect(email.subject).to eq(I18n.t('mailers.loan_version_rejected.subject', meta: '[test]'))
    expect(email.to).to eq([investment_manager.email])
  end

  it 're-creates a new validated version from last one' do
    context = RejectLoanVersionInteractor.call(loan_version: loan_version_ratified, user: administrator,
                                               validation_object: 'version')
    expect(context).to be_success

    new_loan = loan.reload
    new_loan_version = new_loan.active_loan_version
    expect(new_loan_version.status).to eq(LoanVersion::STATUS_ASSIGNED)
    expect(new_loan_version.version_status).to eq(LoanVersion::VERSION_STATUS_VALIDATED)
    expect(new_loan_version.validation_user).to eq(administrator)
    expect(new_loan_version.creation_user).to eq(administrator)
  end

  it 'sends a rejection email' do
    context = RejectLoanVersionInteractor.call(loan_version: loan_version_ratified, user: administrator,
                                               validation_object: 'version')
    expect(context).to be_success

    email = ActionMailer::Base.deliveries.first
    expect(email.subject).to eq(I18n.t('mailers.loan_version_rejected.subject', meta: '[test]'))
    expect(email.to).to eq([investment_manager.email])
  end

  it 'rejects repayment calendar if repayment calendar exists' do
    context = RejectLoanVersionInteractor.call(loan_version: invested_loan_version_invested, user: administrator,
                                               validation_object: 'version')
    expect(context).to be_success

    new_loan = loan.reload
    repayment_calendar = RepaymentCalendar.find(invested_repayment_calendar.id)
    expect(repayment_calendar.version_status).to eq(LoanVersion::VERSION_STATUS_REJECTED)
    expect(repayment_calendar.rejection_user).to eq(administrator)
    repayment_calendar = new_loan.active_repayment_calendar
    expect(repayment_calendar).to be_falsey
  end

  it 'creates a calendar log line if calendar exists' do
    context = RejectLoanVersionInteractor.call(loan_version: invested_loan_version_invested, user: administrator,
                                               validation_object: 'version')
    expect(context).to be_success

    log_line = calendar_log.reload.lines.first

    expect(log_line.action).to eq(CalendarLogLine::ACTION_REJECTION)
    expect(log_line.original_value).to eq(RepaymentCalendar::VERSION_STATUS_TEMPORARY)
    expect(log_line.new_value).to eq(RepaymentCalendar::VERSION_STATUS_REJECTED)
  end
end
