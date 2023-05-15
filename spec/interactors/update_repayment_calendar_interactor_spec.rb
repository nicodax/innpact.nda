# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UpdateRepaymentCalendarInteractor do
  include_context 'shared factories'

  let!(:currency_1) { create(:currency, fund: fund) }
  let!(:currency_2) { create(:currency, fund: fund) }
  let!(:pool) { create(:pool, :targeted, fund: fund) }
  let!(:loan_type_1) { create(:loan_type, fund: fund) }
  let!(:loan_type_2) { create(:loan_type, fund: fund) }
  let!(:repayment_type_1) { create(:repayment_type, fund: fund) }
  let!(:repayment_type_2) { create(:repayment_type, fund: fund) }

  let!(:loan) do
    create(:loan, institution_id: institution.id, im_group: default_im_group,
                  innpact_loan_id: rand(1000), last_loan_version: 1, fund: fund,
                  creation_user: investment_manager)
  end

  let!(:invested_loan_version) do
    create(:loan_version, :invested, loan: loan,
                                     version_status: LoanVersion::VERSION_STATUS_VALIDATED,
                                     validation_user: administrator, executed_nominal_amount: 1000,
                                     creation_user: investment_manager)
  end

  let(:repayment_line_principal) { build(:repayment_calendar_line, original_amount: 1000) }
  let(:paid_repayment_line_principal) {
    build(:repayment_calendar_line, original_amount: 1000, repayment_date: 4.days.ago)
  }

  let!(:repayment_calendar) do
    create(:repayment_calendar, loan_version: invested_loan_version,
                                repayment_calendar_lines: [repayment_line_principal],
                                creation_user: administrator)
  end

  let(:repayment_date) { 1.day.ago }

  let(:repayment_calendar_params_for_principal_update) do
    {
      'principal_repayment_lines_attributes' => {
        '0' => {
          'repayment_date' => repayment_date.strftime('%d-%m-%Y'),
          'original_amount' => 1000,
          'received_amount' => 1000,
          'status' => 'paid',
          'repayment_type' => 'principal',
          'provision' => '0.0',
          '_destroy' => 'false',
          'id' => repayment_calendar.repayment_calendar_lines.principal.first.id
        }
      },
      'interest_repayment_lines_attributes' => {}
    }
  end

  let(:repayment_calendar_params_for_principal_provision_update) do
    {
      'principal_repayment_lines_attributes' => {
        '0' => {
          'repayment_date' => repayment_line_principal.repayment_date.strftime('%d-%m-%Y'),
          'original_amount' => 1000,
          'received_amount' => 0,
          'status' => repayment_line_principal.status,
          'repayment_type' => 'principal',
          'provision' => 10.0,
          '_destroy' => 'false',
          'id' => repayment_calendar.repayment_calendar_lines.principal.first.id
        }
      },
      'interest_repayment_lines_attributes' => {}
    }
  end

  let(:repayment_calendar_params_for_too_big_principal_provision_update) do
    {
      'principal_repayment_lines_attributes' => {
        '0' => {
          'repayment_date' => repayment_line_principal.repayment_date.strftime('%d-%m-%Y'),
          'original_amount' => 1000,
          'received_amount' => 0,
          'status' => repayment_line_principal.status,
          'repayment_type' => 'principal',
          'provision' => invested_loan_version.executed_nominal_amount + 10,
          '_destroy' => 'false',
          'id' => repayment_calendar.repayment_calendar_lines.principal.first.id
        }
      },
      'interest_repayment_lines_attributes' => {}
    }
  end

  let(:repayment_calendar_params_for_principal_addition) do
    {
      'principal_repayment_lines_attributes' => {
        '0' => {
          'repayment_date' => repayment_line_principal.repayment_date.strftime('%d-%m-%Y'),
          'original_amount' => 1000,
          'received_amount' => '0.0',
          'status' => repayment_line_principal.status,
          'repayment_type' => 'principal',
          'provision' => '0.0',
          '_destroy' => 'false',
          'id' => repayment_calendar.repayment_calendar_lines.principal.first.id
        },
        '1611520388715' => {
          'repayment_date' => (Date.today + 1.month).strftime('%d-%m-%Y'),
          'original_amount' => '100',
          'received_amount' => '0.0',
          'status' => 'pending',
          'repayment_type' => 'interest',
          'provision' => '0.0',
          '_destroy' => 'false'
        }
      },
      'interest_repayment_lines_attributes' => {}
    }
  end

  let(:repayment_calendar_params_with_restructuring_update) do
    {
      'principal_repayment_lines_attributes' => {
        '0' => {
          'repayment_date' => paid_repayment_line_principal.repayment_date.strftime('%d-%m-%Y'),
          'original_amount' => 1000,
          'received_amount' => 100,
          'status' => 'paid', # paid_repayment_line_principal.status,
          'repayment_type' => 'principal',
          'provision' => '0.0',
          '_destroy' => 'false',
          'id' => repayment_calendar.repayment_calendar_lines.principal.first.id
        },
        '1' => {
          'repayment_date' => (Date.today + 1.month).strftime('%d-%m-%Y'),
          'original_amount' => 900,
          'received_amount' => 0.0,
          'status' => 'pending',
          'repayment_type' => 'principal',
          'provision' => '0.0',
          '_destroy' => 'false',
          'id' => repayment_calendar.repayment_calendar_lines.principal.first.id
        }
      },
      'interest_repayment_lines_attributes' => {}
    }
  end

  let(:repayment_calendar_invalid_params) do
    {
      'principal_repayment_lines_attributes' => {
        '0' => {
          'repayment_date' => repayment_line_principal.repayment_date.strftime('%d-%m-%Y'),
          'original_amount' => 1000,
          'received_amount' => 1000,
          'status' => nil,
          'repayment_type' => 'principal',
          'provision' => '0.0',
          '_destroy' => 'false',
          'id' => repayment_calendar.repayment_calendar_lines.principal.first.id
        }
      },
      'interest_repayment_lines_attributes' => {}
    }
  end

  let!(:loan_1) do
    create(:loan, institution_id: institution.id, im_group: default_im_group,
                innpact_loan_id: rand(1000), last_loan_version: 1, fund: fund,
                creation_user: investment_manager)
  end
  let!(:loan_version_1) do
      create(:loan_version, :invested, loan: loan_1,
                                      version_status: LoanVersion::VERSION_STATUS_VALIDATED,
                                      version_number: 1, validation_user: administrator,
                                      creation_user: investment_manager,
                                      maturity_date: Date.today - 1.day,
                                      executed_nominal_amount: 50.3 * 2
                                  )
  end
  let!(:loan_2) do
      create(:loan, institution_id: institution.id, im_group: default_im_group,
                  innpact_loan_id: rand(1000), last_loan_version: 1, fund: fund,
                  creation_user: investment_manager)
  end
  let!(:loan_version_2) do
      create(:loan_version, :matured, loan: loan_2,
                                      version_status: LoanVersion::VERSION_STATUS_VALIDATED,
                                      version_number: 1, validation_user: administrator,
                                      creation_user: investment_manager,
                                      executed_nominal_amount: 50.3 * 2,
                                  )
  end

  let!(:repayment_calendar_1) do create(:repayment_calendar, loan_version: loan_version_1)
  end
  
  let!(:repayment_calendar_2) do create(:repayment_calendar, loan_version: loan_version_2, repayment_calendar_lines: [
    build(
      :repayment_calendar_line,
      repayment_date: Date.today - 1.month, 
      original_amount: repayment_calendar_1.repayment_calendar_lines.first.original_amount, 
      received_amount: repayment_calendar_1.repayment_calendar_lines.first.original_amount, 
      status: 'paid', 
      provision: 0.0
    ),
    build(
      :repayment_calendar_line,
      repayment_date: Date.today - 1.month, 
      original_amount: repayment_calendar_1.repayment_calendar_lines.first.original_amount, 
      received_amount: repayment_calendar_1.repayment_calendar_lines.first.original_amount, 
      status: 'paid', 
      provision: 0.0
    ),
  ])
  end

  before do
    loan.reload
  end

  it 'create a new calendar versions' do
    context = UpdateRepaymentCalendarInteractor.call(loan: loan, params: repayment_calendar_params_for_principal_update,
                                                     user: administrator)
    expect(context).to be_success

    new_loan = loan.reload
    expect(new_loan.last_loan_version).to eq(2)
  end

  it 'updates monetary values on loan_version for update' do
    context = UpdateRepaymentCalendarInteractor.call(loan: loan, params: repayment_calendar_params_for_principal_update,
                                                     user: administrator)
    expect(context).to be_success

    new_loan = loan.reload
    new_loan_version = new_loan.active_loan_version

    expect(new_loan_version.net_position_value).to eq(0)
    expect(new_loan_version.gross_position_value).to eq(0)
    expect(new_loan_version.provision_value).to eq(0)
  end


  context 'modification is made by administrator' do
    it 'automatically validate repayment calendar and sends an email to investment advisor' do
      context = UpdateRepaymentCalendarInteractor.call(loan: loan, params: repayment_calendar_params_for_principal_update,
                                                       user: administrator)
      expect(context).to be_success

      new_loan = loan.reload
      new_calendar = new_loan.active_repayment_calendar
      expect(new_calendar.version_status).to eq(RepaymentCalendar::VERSION_STATUS_VALIDATED)
      expect(new_calendar.validation_user).to eq(administrator)

      emails = ActionMailer::Base.deliveries
      expect(emails.last.subject).to eq(I18n.t('mailers.mail_repayment_calendar_update.subject', meta: '[test]'))
      expect(emails.map(&:to).flatten).to include(investment_manager.email, general_manager.email)
      expect(emails.map(&:to).flatten).not_to include(administrator.email)
    end
  end

  context 'modification is made by general_manager' do
    it 'automatically validate repayment calendar and sends an email to investment advisor' do
      context = UpdateRepaymentCalendarInteractor.call(loan: loan, params: repayment_calendar_params_for_principal_update,
                                                       user: general_manager)
      expect(context).to be_success

      new_loan = loan.reload
      new_calendar = new_loan.active_repayment_calendar
      expect(new_calendar.version_status).to eq(RepaymentCalendar::VERSION_STATUS_VALIDATED)
      expect(new_calendar.validation_user).to eq(general_manager)

      emails = ActionMailer::Base.deliveries
      expect(emails.last.subject).to eq(I18n.t('mailers.mail_repayment_calendar_update.subject', meta: '[test]'))
      expect(emails.map(&:to).flatten).to include(administrator.email, investment_manager.email)
      expect(emails.map(&:to).flatten).not_to include(general_manager.email)
    end
  end

  context 'modification is made by investment_manager' do
    it 'set repayment calendar on temporary status and sends an email to team' do
      context = UpdateRepaymentCalendarInteractor.call(loan: loan, params: repayment_calendar_params_for_principal_update,
                                                       user: investment_manager)
      expect(context).to be_success

      new_loan = loan.reload
      new_calendar = new_loan.active_repayment_calendar
      expect(new_calendar.version_status).to eq(RepaymentCalendar::VERSION_STATUS_TEMPORARY)
      expect(new_calendar.validation_user).to be_falsey

      emails = ActionMailer::Base.deliveries
      expect(emails.first.subject).to eq(I18n.t('mailers.investment_manager_repayment_calendar_update.subject', meta: '[test]'))
      # TODO: even though this expectation is part of the business logic,
      #  RepaymentCalendarMailer.investment_manager_repayment_calendar_update never sent emails to the
      #  investment managers, the test was passing because of the emails sent by the LoanMailer.
      # The implementation should be reviewed
      # expect(emails.map(&:to).flatten).to include(investment_manager.email)
    end
  end

  it 'duplicate calendar lines with updated info' do
    context = UpdateRepaymentCalendarInteractor.call(loan: loan, params: repayment_calendar_params_for_principal_update,
                                                     user: administrator)
    expect(context).to be_success

    new_loan = loan.reload
    new_calendar = new_loan.active_repayment_calendar
    expect(new_calendar.repayment_calendar_lines.size).to eq(1)

    new_repayment_line = new_calendar.repayment_calendar_lines.first
    expect(new_repayment_line.received_amount).to eq(1000)
    expect(new_repayment_line.status).to eq(RepaymentCalendarLine::STATUS_PAID)
    expect(new_repayment_line.previous_version_line_id).to eq(repayment_line_principal.id)
  end

  it 'creates a new loan provision if provision is updated' do
    context = UpdateRepaymentCalendarInteractor.call(loan: loan,
                                                     params: repayment_calendar_params_for_principal_provision_update,
                                                     user: administrator)
    expect(context).to be_success

    new_loan = loan.reload
    new_calendar = new_loan.active_repayment_calendar
    loan_provision = new_loan.loan_provisions.first

    expect(loan_provision.repayment_calendar).to eq(new_calendar)
    expect(loan_provision.amount).to eq(10)
    expect(loan_provision.previous_amount_of_provision).to eq(0)
    expect(loan_provision.new_amount_of_provision).to eq(10)
    expect(loan_provision.institution_provision_id).to be_falsey
    expect(loan_provision.creation_user).to eq(administrator)
  end

  it 'updates monetary values on loan_version for update' do
    context = UpdateRepaymentCalendarInteractor.call(loan: loan,
                                                     params: repayment_calendar_params_for_principal_provision_update,
                                                     user: administrator)
    expect(context).to be_success

    new_loan = loan.reload
    new_loan_version = new_loan.active_loan_version

    expect(new_loan_version.gross_position_value).to eq(1000)
    expect(new_loan_version.net_position_value).to eq(990)
    expect(new_loan_version.provision_value).to eq(10)
    expect(new_loan_version.provision_date).to eq(Date.today)
  end

  it 'raises an error if provision is > than principal amount' do
    context = UpdateRepaymentCalendarInteractor.call(loan: loan,
                                                     params: repayment_calendar_params_for_too_big_principal_provision_update,
                                                     user: administrator)
    expect(context).not_to be_success
  end

  it 'creates a log for updates' do
    context = UpdateRepaymentCalendarInteractor.call(loan: loan,
                                                     params: repayment_calendar_params_for_principal_update,
                                                     user: administrator)
    expect(context).to be_success

    new_loan = loan.reload
    new_calendar = new_loan.active_repayment_calendar
    new_repayment_line = new_calendar.repayment_calendar_lines.first
    calendar_log = new_calendar.calendar_log
    expect(calendar_log.creation_user).to eq(administrator)
    expect(calendar_log.lines.size).to eq(3)
    expect(calendar_log.lines.map(&:action)).to match_array(%w[update update update])
    expect(calendar_log.lines.map(&:original_repayment_line_id)).to match_array([repayment_line_principal.id, repayment_line_principal.id, repayment_line_principal.id])
    expect(calendar_log.lines.map(&:new_repayment_line_id)).to match_array([new_repayment_line.id, new_repayment_line.id, new_repayment_line.id])
    expect(calendar_log.lines.map(&:changed_attribute)).to match_array(%w[received_amount status repayment_date])
    expect(calendar_log.lines.map(&:original_value)).to match_array(['0.0', 'pending', repayment_line_principal.repayment_date.strftime('%d-%m-%Y')])
    expect(calendar_log.lines.map(&:new_value)).to match_array([repayment_date.strftime('%d-%m-%Y'), '1000.0', 'paid'])
  end

  it 'adds new lines' do
    context = UpdateRepaymentCalendarInteractor.call(loan: loan,
                                                     params: repayment_calendar_params_for_principal_addition,
                                                     user: administrator)
    expect(context).to be_success

    new_loan = loan.reload
    new_calendar = new_loan.active_repayment_calendar
    expect(new_calendar.repayment_calendar_lines.size).to eq(2)

    new_repayment_line = new_calendar.repayment_calendar_lines.detect { |l| l.original_amount == 100 }
    expect(new_repayment_line.received_amount).to eq(0)
    expect(new_repayment_line.status).to eq(RepaymentCalendarLine::STATUS_PENDING)
    expect(new_repayment_line.previous_version_line_id).to be_falsey
  end

  it 'creates a log for addition' do
    context = UpdateRepaymentCalendarInteractor.call(loan: loan,
                                                     params: repayment_calendar_params_for_principal_addition,
                                                     user: administrator)
    expect(context).to be_success

    new_loan = loan.reload
    new_calendar = new_loan.active_repayment_calendar
    new_repayment_line = new_calendar.repayment_calendar_lines.detect { |l| l.original_amount == 100 }
    calendar_log = new_calendar.calendar_log
    expect(calendar_log.creation_user).to eq(administrator)
    expect(calendar_log.lines.size).to eq(1)
    calendar_log_line = calendar_log.lines.first
    expect(calendar_log_line.action).to eq('creation')
    expect(calendar_log_line.original_repayment_line_id).to be_falsey
    expect(calendar_log_line.new_repayment_line_id).to eq(new_repayment_line.id)
    expect(calendar_log_line.changed_attribute).to be_falsey
    expect(calendar_log_line.original_value).to be_falsey
    expect(calendar_log_line.new_value).to be_falsey
  end

  it 'flags loan as restructuring if repayment is updated with received amount different than original amount' do
    context = UpdateRepaymentCalendarInteractor.call(loan: loan,
                                                     params: repayment_calendar_params_with_restructuring_update,
                                                     user: administrator)
    expect(context).to be_success

    new_loan = loan.reload
    expect(new_loan.restructuring).to be_truthy
  end

  it 'does not create new version and calendar logs if changes are not valid' do
    context = UpdateRepaymentCalendarInteractor.call(loan: loan, params: repayment_calendar_invalid_params,
                                                     user: administrator)
    expect(context).not_to be_success
    expect(context.repayment_calendar).not_to be_valid

    new_loan = loan.reload
    expect(new_loan.last_loan_version).to eq(1)

    calendar_log = new_loan.active_loan_version.repayment_calendar.calendar_log
    expect(calendar_log).to be_falsey
  end

  it 'update the loan_version maturity_date with the last pending repayment date when calendar is updated' do
    pending 'Automatic maturity date update (MEF-763)'
    last_repayment_date = Date.today + 10.month
    principal_repayment_lines_attributes = repayment_calendar_1.principal_lines_attributes
    principal_repayment_lines_attributes.first['status'] = RepaymentCalendarLine::STATUS_PAID
    principal_repayment_lines_attributes.first['received_amount'] = principal_repayment_lines_attributes.first['original_amount']
    principal_repayment_lines_attributes.first['repayment_date'] = Date.today - 1.month
    principal_repayment_lines_attributes.last['status'] = RepaymentCalendarLine::STATUS_PENDING
    principal_repayment_lines_attributes.last['repayment_date'] = last_repayment_date
    context = UpdateRepaymentCalendarInteractor.call(
        loan: loan_1,
        params: {
          'principal_repayment_lines_attributes'=>{
            repayment_line_1: principal_repayment_lines_attributes.first,
            repayment_line_2: principal_repayment_lines_attributes.last
          }
        },
        user: User.first
    )
    expect(context).to be_success

    new_loan = Loan.where(id: loan_1.id).first
    expect(new_loan.last_loan_version).to eq(2)

    new_loan_version = LoanVersion.where(loan_id: loan_1.id).where(version_number: new_loan.last_loan_version).first
    expect(new_loan_version[:maturity_date]).to eql(last_repayment_date)
  end

  it 'update the loan_version maturity_date with the last repayment date if there is no pending repayment date when calendar is updated' do
    pending 'Automatic maturity date update (MEF-763)'
    last_repayment_date = Date.today - 10.day
    principal_repayment_lines_attributes = repayment_calendar_1.principal_lines_attributes
    principal_repayment_lines_attributes.first['status'] = RepaymentCalendarLine::STATUS_PAID
    principal_repayment_lines_attributes.first['received_amount'] = principal_repayment_lines_attributes.first['original_amount']
    principal_repayment_lines_attributes.first['repayment_date'] = Date.today - 1.month
    principal_repayment_lines_attributes.last['status'] = RepaymentCalendarLine::STATUS_PAID
    principal_repayment_lines_attributes.last['repayment_date'] = last_repayment_date
    principal_repayment_lines_attributes.last['received_amount'] = principal_repayment_lines_attributes.last['original_amount']
    context = UpdateRepaymentCalendarInteractor.call(
        loan: loan_1,
        params: {
          'principal_repayment_lines_attributes'=>{
            repayment_line_1: principal_repayment_lines_attributes.first,
            repayment_line_2: principal_repayment_lines_attributes.last
          }
        },
        user: User.first
    )
    expect(context).to be_success
    new_loan = Loan.where(id: loan_1.id).first
    expect(new_loan.last_loan_version).to eq(2)

    new_loan_version = LoanVersion.where(loan_id: loan_1.id).where(version_number: new_loan.last_loan_version).first
    expect(new_loan_version[:maturity_date]).to eql(last_repayment_date)
  end

  it 'update the status of a loan from invested to matured if the updated maturity date is in the past.' do
    pending 'Automatic maturity date update (MEF-763)'
    last_repayment_date = Date.today - 10.day
    principal_repayment_lines_attributes = repayment_calendar_1.principal_lines_attributes
    principal_repayment_lines_attributes.first['status'] = RepaymentCalendarLine::STATUS_PAID
    principal_repayment_lines_attributes.first['received_amount'] = principal_repayment_lines_attributes.first['original_amount']
    principal_repayment_lines_attributes.first['repayment_date'] = Date.today - 1.month
    principal_repayment_lines_attributes.last['status'] = RepaymentCalendarLine::STATUS_PAID
    principal_repayment_lines_attributes.last['repayment_date'] = last_repayment_date
    principal_repayment_lines_attributes.last['received_amount'] = principal_repayment_lines_attributes.last['original_amount']
    context = UpdateRepaymentCalendarInteractor.call(
        loan: loan_1,
        params: {
          'principal_repayment_lines_attributes'=>{
            repayment_line_1: principal_repayment_lines_attributes.first,
            repayment_line_2: principal_repayment_lines_attributes.last
          }
        },
        user: User.first
    )
    expect(context).to be_success
    new_loan = Loan.where(id: loan_1.id).first
    expect(new_loan.last_loan_version).to eq(2)

    new_loan_version = LoanVersion.where(loan_id: loan_1.id).where(version_number: new_loan.last_loan_version).first
    expect(new_loan_version[:maturity_date]).to eql(last_repayment_date)
    expect(new_loan.status).to eq(LoanVersion::STATUS_MATURED)
  end

  it 'update the status of a loan from invested to matured if the updated maturity date is in the past.' do
    pending 'Automatic maturity date update (MEF-763)'
    principal_repayment_lines_attributes = repayment_calendar_2.principal_lines_attributes
    principal_repayment_lines_attributes.last['status'] = RepaymentCalendarLine::STATUS_PAID
    principal_repayment_lines_attributes.last['received_amount'] = principal_repayment_lines_attributes.first['original_amount']
    principal_repayment_lines_attributes.last['repayment_date'] = Date.today - 1.month
    principal_repayment_lines_attributes.first['status'] = RepaymentCalendarLine::STATUS_PENDING
    principal_repayment_lines_attributes.first['repayment_date'] = Date.today + 10.day
    principal_repayment_lines_attributes.first['received_amount'] = 0
    context = UpdateRepaymentCalendarInteractor.call(
        loan: loan_2,
        params: {
          'principal_repayment_lines_attributes'=>{
            repayment_line_1: principal_repayment_lines_attributes.first,
            repayment_line_2: principal_repayment_lines_attributes.last
          }
        },
        user: User.first
    )
    expect(context).to be_success
    new_loan = Loan.where(id: loan_2.id).first
    expect(new_loan.last_loan_version).to eq(2)
    new_loan_version = LoanVersion.where(loan_id: loan_2.id).where(version_number: new_loan.last_loan_version).first
    expect(new_loan_version[:maturity_date]).to eql(Date.today + 10.day)
    expect(new_loan.status).to eq(LoanVersion::STATUS_INVESTED)
    email = ActionMailer::Base.deliveries.first
    expect(email.subject).to eq(I18n.t('mailers.loan_update_without_validation_link.subject', meta: '[test]'))
  end
end
