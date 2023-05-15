# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RejectRepaymentCalendarInteractor do
  let!(:currency_1) { create(:currency, fund: fund) }
  let!(:pool) { create(:pool, :targeted, fund: fund) }
  let!(:loan_type_1) { create(:loan_type, fund: fund) }
  let!(:repayment_type_1) { create(:repayment_type, fund: fund) }

  let!(:loan) do
    create(:loan, institution_id: institution.id, im_group: default_im_group,
                  creation_user: investment_manager, innpact_loan_id: rand(1000),
                  last_loan_version: 2, fund: fund)
  end
  let!(:loan_version) do
    create(:loan_version, :invested, loan: loan,
                                     version_status: LoanVersion::VERSION_STATUS_VALIDATED,
                                     version_number: 1, creation_user: investment_manager,
                                     validation_user: administrator)
  end
  let!(:repayment_calendar_1) do
    create(:repayment_calendar, version_status: RepaymentCalendar::VERSION_STATUS_VALIDATED,
                                loan_version: loan_version, creation_user: investment_manager,
                                validation_user: administrator)
  end
  let!(:repayment_calendar_line_1) do
    create(:repayment_calendar_line, repayment_calendar: repayment_calendar_1)
  end
  let!(:loan_version_2) do
    create(:loan_version, :invested, loan: loan,
                                     version_status: LoanVersion::VERSION_STATUS_TEMPORARY,
                                     version_number: 2, creation_user: investment_manager,
                                     validation_user: administrator)
  end
  let!(:repayment_calendar_2) do
    create(:repayment_calendar, version_status: RepaymentCalendar::VERSION_STATUS_TEMPORARY,
                                loan_version: loan_version_2, creation_user: investment_manager)
  end
  let!(:repayment_calendar_line_2) do
    create(:repayment_calendar_line, repayment_calendar: repayment_calendar_2)
  end
  let!(:calendar_log) do
    create(:calendar_log, repayment_calendar: repayment_calendar_2, creation_user: investment_manager)
  end

  let!(:invested_loan_temporary) do
    create(:loan, institution_id: institution.id, im_group: default_im_group,
                  innpact_loan_id: rand(1000), last_loan_version: 2, fund: fund,
                  creation_user: investment_manager)
  end
  let!(:invested_loan_temporary_version_approved) do
    create(:loan_version, :approved, loan: invested_loan_temporary,
                                     version_status: LoanVersion::VERSION_STATUS_VALIDATED,
                                     version_number: 1, validation_user: administrator,
                                     creation_user: investment_manager)
  end
  let!(:invested_loan_temporary_version_invested) do
    create(:loan_version, :invested, loan: invested_loan_temporary,
                                     version_status: LoanVersion::VERSION_STATUS_TEMPORARY,
                                     version_number: 2, creation_user: investment_manager)
  end
  let!(:invested_repayment_calendar_temporary) do
    create(:repayment_calendar, loan_version: invested_loan_temporary_version_invested,
                                version_status: RepaymentCalendar::VERSION_STATUS_TEMPORARY,
                                creation_user: investment_manager)
  end
  let!(:calendar_log) do
    create(:calendar_log, repayment_calendar: invested_repayment_calendar_temporary,
                          creation_user: investment_manager)
  end

  it 'rejects a repayment calendar', skip: 'reject loan version and repayment calendar at one' do
    context = RejectRepaymentCalendarInteractor.call(repayment_calendar: repayment_calendar_2, user: administrator)
    expect(context).to be_success

    new_loan = loan.reload
    rejected_repayment_calendar = RepaymentCalendar.find(repayment_calendar_2.id)
    expect(rejected_repayment_calendar.version_status).to eq(RepaymentCalendar::VERSION_STATUS_REJECTED)
    expect(rejected_repayment_calendar.rejection_user).to eq(administrator)
    expect(new_loan.last_loan_version).to eq(3)
    new_repayment_calendar = new_loan.active_repayment_calendar

    expect(new_repayment_calendar.version_status).to eq(RepaymentCalendar::VERSION_STATUS_VALIDATED)
    expect(new_repayment_calendar.validation_user).to eq(administrator)
    expect(new_repayment_calendar.creation_user).to eq(administrator)

    repayment_line = new_repayment_calendar.repayment_calendar_lines.first
    expect(repayment_line.repayment_date).to eq(repayment_calendar_line_1.repayment_date)
    expect(repayment_line.repayment_type).to eq(repayment_calendar_line_1.repayment_type)
    expect(repayment_line.original_amount).to eq(repayment_calendar_line_1.original_amount)

    email = ActionMailer::Base.deliveries.first
    expect(email.subject).to eq(I18n.t('mailers.repayment_calendar_rejected.subject', meta: '[test]'))
    expect(email.to).to eq([investment_manager.email])

    log_line = calendar_log.reload.lines.first

    expect(log_line.action).to eq(CalendarLogLine::ACTION_REJECTION)
    expect(log_line.original_value).to eq(RepaymentCalendar::VERSION_STATUS_TEMPORARY)
    expect(log_line.new_value).to eq(RepaymentCalendar::VERSION_STATUS_REJECTED)
  end
end
