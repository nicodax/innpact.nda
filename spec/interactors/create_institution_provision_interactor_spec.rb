# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CreateInstitutionProvisionInteractor do
  include_context 'shared factories'

  let!(:loan_1) do
    create(:loan, institution: institution, last_loan_version: 1, creation_user: general_manager,
                  im_group: default_im_group)
  end
  let!(:loan_version_1) do
    create(:loan_version, :invested, loan: loan_1, version_number: 1, executed_nominal_amount: 80_000,
                                     gross_position_value: 70_000, provision_value: 0,
                                     creation_user: general_manager)
  end
  let!(:repayment_calendar_1) do
    create(:repayment_calendar, loan_version: loan_version_1, creation_user: general_manager, repayment_calendar_lines: [
             RepaymentCalendarLine.new(repayment_type: RepaymentCalendarLine::REPAYMENT_TYPE_PRINCIPAL,
                                       original_amount: 10_000, received_amount: 10_000,
                                       repayment_date: Date.today - 1.month,
                                       status: RepaymentCalendarLine::STATUS_PAID),
             RepaymentCalendarLine.new(repayment_type: RepaymentCalendarLine::REPAYMENT_TYPE_PRINCIPAL,
                                       original_amount: 60_000,
                                       repayment_date: Date.today + 1.month),
             RepaymentCalendarLine.new(repayment_type: RepaymentCalendarLine::REPAYMENT_TYPE_PRINCIPAL,
                                       original_amount: 10_000,
                                       repayment_date: Date.today + 1.month),
             RepaymentCalendarLine.new(repayment_type: RepaymentCalendarLine::REPAYMENT_TYPE_INTEREST,
                                       original_amount: 100,
                                       repayment_date: Date.today + 1.month)
           ])
  end

  let!(:loan_2) do
    create(:loan, institution: institution, last_loan_version: 1, creation_user: general_manager,
                  im_group: default_im_group)
  end
  let!(:loan_version_2) do
    create(:loan_version, :invested, loan: loan_2, version_number: 1, executed_nominal_amount: 20_000,
                                     gross_position_value: 19_000, provision_value: 89,
                                     creation_user: general_manager)
  end
  let!(:repayment_calendar_2) do
    create(:repayment_calendar, loan_version: loan_version_2, creation_user: general_manager, repayment_calendar_lines: [
             RepaymentCalendarLine.new(repayment_type: RepaymentCalendarLine::REPAYMENT_TYPE_PRINCIPAL,
                                       original_amount: 1000,
                                       received_amount: 1000, repayment_date: Date.today - 1.month,
                                       status: RepaymentCalendarLine::STATUS_PAID),
             RepaymentCalendarLine.new(repayment_type: RepaymentCalendarLine::REPAYMENT_TYPE_PRINCIPAL,
                                       original_amount: 4500,
                                       repayment_date: Date.today + 1.month),
             RepaymentCalendarLine.new(repayment_type: RepaymentCalendarLine::REPAYMENT_TYPE_PRINCIPAL,
                                       original_amount: 4500,
                                       repayment_date: Date.today + 1.month),
             RepaymentCalendarLine.new(repayment_type: RepaymentCalendarLine::REPAYMENT_TYPE_PRINCIPAL,
                                       original_amount: 5000,
                                       repayment_date: Date.today + 1.month),
             RepaymentCalendarLine.new(repayment_type: RepaymentCalendarLine::REPAYMENT_TYPE_PRINCIPAL,
                                       original_amount: 5000,
                                       provision: 89, repayment_date: Date.today + 1.month),
             RepaymentCalendarLine.new(repayment_type: RepaymentCalendarLine::REPAYMENT_TYPE_INTEREST,
                                       original_amount: 100,
                                       repayment_date: Date.today + 1.month)
           ])
  end

  let(:comment) { FFaker::Lorem.sentence }

  it 'creates a new institution provision' do
    context = CreateInstitutionProvisionInteractor.call(institution: institution, user: administrator,
                                                        provision_percentage: 0.1, comment: comment)

    expect(context).to be_success

    institution.reload
    institution_provision = institution.institution_provisions.first

    expect(institution_provision.percentage).to eq(0.1)
    expect(institution_provision.comment).to eq(comment)
    expect(institution_provision.previous_percentage_of_provision).to eq(0.0)
    expect(institution_provision.new_percentage_of_provision).to eq(0.1)
    expect(institution_provision.creation_user).to eq(administrator)
  end

  it 'creates new loan provisions' do
    context = CreateInstitutionProvisionInteractor.call(institution: institution, user: administrator,
                                                        provision_percentage: 0.1, comment: comment)

    expect(context).to be_success

    institution.reload
    institution_provision = institution.institution_provisions.first

    loan_provision = institution_provision.loan_provisions.where(loan_id: loan_1.id).first
    expect(loan_provision.percentage).to eq(0.1)
    expect(loan_provision.previous_amount_of_provision).to eq(0)
    expect(loan_provision.new_amount_of_provision).to eq(7000)
    expect(loan_provision.creation_user).to eq(administrator)
    expect(loan_provision.repayment_calendar).to eq(loan_1.reload.active_repayment_calendar)

    loan_provision = institution_provision.loan_provisions.where(loan_id: loan_2.id).first
    expect(loan_provision.percentage).to eq(0.1)
    expect(loan_provision.previous_amount_of_provision).to eq(89)
    expect(loan_provision.new_amount_of_provision).to eq(1900)
    expect(loan_provision.creation_user).to eq(administrator)
    expect(loan_provision.repayment_calendar).to eq(loan_2.reload.active_repayment_calendar)
  end

  it 'creates new loan version' do
    context = CreateInstitutionProvisionInteractor.call(institution: institution, user: administrator,
                                                        provision_percentage: 0.1, comment: comment)

    expect(context).to be_success

    loan_1.reload
    expect(loan_1.last_loan_version).to eq(2)
    expect(loan_1.provision_date).to eq(Date.today)
    expect(loan_1.provision_value).to eq(7000)

    loan_2.reload
    expect(loan_2.last_loan_version).to eq(2)
    expect(loan_2.provision_date).to eq(Date.today)
    expect(loan_2.provision_value).to eq(1900)
  end

  it 'creates new calendar repayment lines as administrator' do
    context = CreateInstitutionProvisionInteractor.call(institution: institution, user: administrator,
                                                        provision_percentage: 0.1, comment: comment)

    expect(context).to be_success

    loan_1.reload
    expect(loan_1.last_loan_version).to eq(2)
    repayment_calendar_lines = loan_1.active_repayment_calendar.repayment_calendar_lines
    expect(repayment_calendar_lines.map(&:provision)).to match_array([6000, 1000, 0, 0])

    loan_2.reload
    expect(loan_2.last_loan_version).to eq(2)
    repayment_calendar_lines = loan_2.active_repayment_calendar.repayment_calendar_lines
    expect(repayment_calendar_lines.map(&:provision)).to match_array([450, 450, 500, 500, 0, 0])
  end

  it 'creates new calendar log' do
    context = CreateInstitutionProvisionInteractor.call(institution: institution, user: administrator,
                                                        provision_percentage: 0.1, comment: comment)

    expect(context).to be_success

    loan_1.reload
    calendar_log_lines = loan_1.active_repayment_calendar.calendar_log.lines

    expect(calendar_log_lines.map(&:action).uniq).to match_array([CalendarLogLine::ACTION_INSTITUTION_PROVISION])
    expect(calendar_log_lines.map(&:changed_attribute).uniq).to eq(['provision'])
    expect(calendar_log_lines.map(&:original_value).uniq).to match_array(['0.0'])
    expect(calendar_log_lines.map(&:new_value)).to match_array(['6000.0', '1000.0'])

    loan_2.reload
    calendar_log_lines = loan_2.active_repayment_calendar.calendar_log.lines

    expect(calendar_log_lines.map(&:action).uniq).to match_array([CalendarLogLine::ACTION_INSTITUTION_PROVISION])
    expect(calendar_log_lines.map(&:changed_attribute).uniq).to eq(['provision'])
    expect(calendar_log_lines.map(&:original_value)).to match_array(['0.0', '0.0', '0.0', '89.0'])
    expect(calendar_log_lines.map(&:new_value)).to match_array(['450.0', '450.0', '500.0', '500.0'])
  end
end
