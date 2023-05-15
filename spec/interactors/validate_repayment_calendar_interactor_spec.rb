# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ValidateRepaymentCalendarInteractor do
  include_context 'shared factories'

  let!(:currency_1) { create(:currency, fund: fund) }
  let!(:pool) { create(:pool, :targeted, fund: fund) }
  let!(:loan_type_1) { create(:loan_type, fund: fund) }
  let!(:repayment_type_1) { create(:repayment_type, fund: fund) }

  let!(:loan) do
    create(:loan, institution_id: institution.id,
                  innpact_loan_id: rand(1000), last_loan_version: 1, fund: fund,
                  creation_user: investment_manager)
  end
  let!(:loan_version) do
    create(:loan_version, :invested, loan: loan,
                                     version_status: LoanVersion::VERSION_STATUS_TEMPORARY,
                                     version_number: 1, creation_user: investment_manager,
                                     validation_user: administrator)
  end
  let!(:repayment_calendar) do
    create(:repayment_calendar, loan_version: loan_version,
                                version_status: RepaymentCalendar::VERSION_STATUS_TEMPORARY,
                                creation_user: investment_manager)
  end
  let!(:repayment_calendar_line) { create(:repayment_calendar_line, repayment_calendar: repayment_calendar) }
  let!(:calendar_log) do
    create(:calendar_log, repayment_calendar: repayment_calendar, creation_user: investment_manager)
  end

  it 'validates loan version', skip: 'validate loan version and repayment calendar at one' do
    context = ValidateRepaymentCalendarInteractor.call(repayment_calendar: repayment_calendar, user: administrator)
    expect(context).to be_success

    new_loan = loan.reload
    loan_version = loan.active_loan_version
    expect(loan_version.version_status).to eq(RepaymentCalendar::VERSION_STATUS_VALIDATED)
    repayment_calendar = new_loan.active_repayment_calendar
    expect(repayment_calendar.version_status).to eq(RepaymentCalendar::VERSION_STATUS_VALIDATED)
    expect(loan_version.validation_user).to eq(administrator)

    email = ActionMailer::Base.deliveries.first
    expect(email.subject).to eq(I18n.t('mailers.repayment_calendar_validated.subject', meta: '[test]'))
    expect(email.to).to eq([investment_manager.email])

    log_line = calendar_log.reload.lines.first

    expect(log_line.action).to eq(CalendarLogLine::ACTION_VALIDATION)
    expect(log_line.original_value).to eq(RepaymentCalendar::VERSION_STATUS_TEMPORARY)
    expect(log_line.new_value).to eq(RepaymentCalendar::VERSION_STATUS_VALIDATED)
  end
end
