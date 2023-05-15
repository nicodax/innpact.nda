# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RollbackLoanFromMaturedToInvestedInteractor do
  include_context 'shared factories'

  let!(:currency1) { create(:currency, fund: fund) }
  let!(:currency2) { create(:currency, fund: fund) }
  let!(:pool) { create(:pool, fund: fund) }
  let!(:bond) { create(:bond, fund: fund) }
  let!(:interest_rate_type) { create(:interest_rate_type, fund: fund) }
  let!(:loan_type1) { create(:loan_type, fund: fund) }
  let!(:loan_type2) { create(:loan_type, fund: fund) }
  let!(:repayment_type1) { create(:repayment_type, fund: fund) }
  let!(:repayment_type2) { create(:repayment_type, fund: fund) }

  let!(:loan) do
    create(:loan,
           institution_id: institution.id,
           im_group: default_im_group,
           innpact_loan_id: rand(1000),
           last_loan_version: 1,
           fund: fund,
           creation_user: investment_manager)
  end

  let!(:loan_version) do
    create(:loan_version,
           :assigned,
           loan: loan,
           status: LoanVersion::STATUS_ASSIGNED,
           version_status: LoanVersion::VERSION_STATUS_VALIDATED,
           validation_user: administrator)
  end

  let!(:approved_loan) do
    create(:loan,
           institution_id: institution.id,
           im_group: default_im_group,
           innpact_loan_id: rand(1000),
           last_loan_version: 1,
           fund: fund,
           creation_user: investment_manager)
  end

  let!(:approved_loan_version) do
    create(:loan_version,
           :approved,
           loan: approved_loan,
           status: LoanVersion::STATUS_APPROVED,
           version_status: LoanVersion::VERSION_STATUS_VALIDATED,
           validation_user: administrator,
           creation_user: investment_manager)
  end

  let(:valid_invested_loan_params) do
    {
      institution_id: institution.id,
      im_group_id: default_im_group.id,
      innpact_loan_id: rand(1000),
      loan_version: {
        status: LoanVersion::STATUS_INVESTED,
        pool_id: pool.id,
        expected_disbursement_date: Time.zone.today + rand(100).days,
        probabilities: rand(1000).to_f / 10,
        currency_id: currency2.id,
        loan_type_id: loan_type2.id,
        executed_nominal_amount: 1000,
        executed_tenor: rand(1000).to_f / 10,
        loan_spread: rand(1000).to_f / 10,
        executed_upfront_fees: rand(1000).to_f / 10,
        executed_fixed_rate: rand(1000).to_f / 10,
        disbursement_date: Time.zone.today + 1.month,
        maturity_date: Time.zone.today + 1.month,
        executed_bond_id: bond.id,
        approved_bond_id: bond.id,
        nav_usd: rand(1000).to_f / 10,
        net_position_value: rand(1000).to_f / 10,
        gross_position_value: rand(1000).to_f / 10,
        loan_interest_rate_type_id: interest_rate_type.id,
        approved_interest_rate_type_id: interest_rate_type.id,
        hedge_comment: 'Test invested hedge',
        invested_hedge_fx_rate: 1.0,
        pending_ratification_comment: 'test',
        ratified_comment: 'test',
        not_ratified_comment: 'test',
        assignement_expired_comment: 'test',
        released_before_approval_comment: 'test',
        pending_approval_comment: 'test',
        approved_comment: 'test',
        not_approved_comment: 'test',
        approval_expired_comment: 'test',
        approved_change_request_comment: 'test',
        invested_comment: 'Invested comment',
        released_after_approval_comment: 'test',
        not_validated_comment: 'test'
      },
      repayment_calendar: {
        repayment_calendar_lines_attributes: { '0': {
          repayment_date: Time.zone.today + rand(100).days,
          repayment_type: RepaymentCalendarLine::REPAYMENT_TYPE_PRINCIPAL,
          original_amount: 1000
        } }
      }
    }
  end

  let(:valid_matured_loan_params) do
    {
      institution_id: institution.id,
      im_group_id: default_im_group.id,
      innpact_loan_id: rand(1000),
      loan_version: {
        status: LoanVersion::STATUS_MATURED,
        pool_id: pool.id,
        expected_disbursement_date: Time.zone.today + rand(100).days,
        probabilities: rand(1000).to_f / 10,
        currency_id: currency2.id,
        loan_type_id: loan_type2.id,
        executed_nominal_amount: 1000,
        executed_tenor: rand(1000).to_f / 10,
        loan_spread: rand(1000).to_f / 10,
        executed_upfront_fees: rand(1000).to_f / 10,
        executed_fixed_rate: rand(1000).to_f / 10,
        disbursement_date: Time.zone.today + 1.month,
        maturity_date: Time.zone.today + 1.month,
        executed_bond_id: bond.id,
        approved_bond_id: bond.id,
        nav_usd: rand(1000).to_f / 10,
        net_position_value: rand(1000).to_f / 10,
        gross_position_value: rand(1000).to_f / 10,
        loan_interest_rate_type_id: interest_rate_type.id,
        approved_interest_rate_type_id: interest_rate_type.id
      }
    }
  end

  subject(:context) { described_class.call(loan: approved_loan) }

  before do
    approved_loan.reload
    UpdateLoanInteractor.call(loan: approved_loan, params: valid_invested_loan_params, user: administrator)
    UpdateLoanInteractor.call(loan: approved_loan, params: valid_matured_loan_params, user: administrator)
  end

  it do
    expect(context).to be_success
  end

  it do
    expect { context }.to change { approved_loan.active_loan_version.version_number }.by(1)
  end

  it do
    expect { context }
      .to change { approved_loan.active_loan_version.status }
      .from(LoanVersion::STATUS_MATURED)
      .to(LoanVersion::STATUS_INVESTED)
  end
end
