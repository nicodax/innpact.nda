# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CreateLoanInteractor do
  include_context 'shared factories'

  let!(:country_1) { create(:country, fund: fund) }
  let!(:country_2) { create(:country, fund: fund) }
  let!(:institution_not_invested) do
    create(:institution, country: country_1, fund: fund, im_group: default_im_group)
  end
  let!(:invested_institution) { create(:institution, fund: fund, im_group: default_im_group) }
  let!(:currency) { create(:currency, fund: fund) }
  let!(:pool) { create(:pool, fund: fund) }
  let!(:targeted_pool_1) do
    create(:pool, fund: fund, countries: [country_1], is_targeted: true, currency: currency)
  end
  let!(:targeted_pool_2) do
    create(:pool, fund: fund, countries: [country_2], is_targeted: true, currency: currency_usd)
  end
  let!(:pool_currency) do
    create(:pool_currency, pool: targeted_pool_2, currency: currency_usd)
  end
  let!(:loan_type) { create(:loan_type, fund: fund) }
  let!(:repayment_type) { create(:repayment_type, fund: fund) }
  let!(:invested_loan) do
    create(:loan, fund: fund, institution: invested_institution, creation_user: general_manager,
                  im_group: default_im_group)
  end
  let!(:loan_version) { create(:loan_version, :invested, loan: invested_loan, creation_user: general_manager) }

  let(:valid_loan_params) do
    {
      innpact_loan_id: rand(1000),
      im_group_id: default_im_group.id,
      loan_version: {
        status: LoanVersion::STATUS_ASSIGNED,
        expected_disbursement_date: Date.today + rand(100).days,
        probabilities: rand(1000).to_f / 10,
        currency_id: currency.id,
        pool_id: pool.id,
        loan_type_id: loan_type.id,
        repayment_type_id: repayment_type.id,
        proposed_nominal_amount: rand(1000).to_f / 10,
        proposed_tenor: rand(100),
        proposed_spread: rand(1000).to_f / 10,
        proposed_upfront_fees: rand(1000).to_f / 10,
        proposed_fixed_rate: rand(1000).to_f / 10,
        assignment_date: Date.today + rand(10).days,
        deadline_assignment_date: Date.today + rand(100).days
      }
    }
  end

  let(:valid_loan_params_with_targeted_pool) do
    {
      innpact_loan_id: rand(1000),
      im_group_id: default_im_group.id,
      loan_version: {
        status: LoanVersion::STATUS_ASSIGNED,
        expected_disbursement_date: Date.today + rand(100).days,
        probabilities: rand(1000).to_f / 10,
        currency_id: currency.id,
        pool_id: targeted_pool_1.id,
        loan_type_id: loan_type.id,
        repayment_type_id: repayment_type.id,
        proposed_nominal_amount: rand(1000).to_f / 10,
        proposed_tenor: rand(100),
        proposed_spread: rand(1000).to_f / 10,
        proposed_upfront_fees: rand(1000).to_f / 10,
        proposed_fixed_rate: rand(1000).to_f / 10,
        assignment_date: Date.today + rand(10).days,
        deadline_assignment_date: Date.today + rand(100).days
      }
    }
  end

  let(:invalid_loan_params_with_wrong_targeted_pool) do
    {
      innpact_loan_id: rand(1000),
      loan_version: {
        status: LoanVersion::STATUS_ASSIGNED,
        expected_disbursement_date: Date.today + rand(100).days,
        probabilities: rand(1000).to_f / 10,
        currency_id: currency.id,
        pool_id: targeted_pool_2.id,
        loan_type_id: loan_type.id,
        repayment_type_id: repayment_type.id,
        proposed_nominal_amount: rand(1000).to_f / 10,
        proposed_tenor: rand(100),
        proposed_spread: rand(1000).to_f / 10,
        proposed_upfront_fees: rand(1000).to_f / 10,
        proposed_fixed_rate: rand(1000).to_f / 10,
        assignment_date: Date.today + rand(10).days,
        deadline_assignment_date: Date.today + rand(100).days
      }
    }
  end

  let(:incomplete_loan_params) do
    {
      loan_version: {
        status: LoanVersion::STATUS_ASSIGNED
      }
    }
  end

  it 'creates a new valid loan with administrator role for a new institution' do
    context = CreateLoanInteractor.call(fund: fund,
                                        params: valid_loan_params
      .merge({ institution_id: institution_not_invested.id }), user: administrator)
    expect(context).to be_success

    loan = context.loan
    expect(loan.creation_user).to eq(administrator)
    expect(loan.im_group_id).to eq(default_im_group.id)
    expect(loan.fund).to eq(fund)
    expect(loan.last_loan_version).to eq(1)
    expect(loan.institution_mode_at_creation).to eq(Loan::NEW_INSTITUTION_MODE)
    loan_version = loan.active_loan_version
    expect(loan_version.status).to eq(LoanVersion::STATUS_ASSIGNED)
    expect(loan_version.version_status).to eq(LoanVersion::VERSION_STATUS_VALIDATED)
    expect(loan_version.creation_user).to eq(administrator)

    emails = ActionMailer::Base.deliveries
    expect(emails).not_to be_nil
    expect(emails.first.subject).to eq(I18n.t('mailers.loan_creation_without_validation_link.subject', meta: '[test]'))
    expect(emails.map(&:to).flatten).not_to include(administrator.email)
  end

  it 'creates a new valid loan with a targeted_pool' do
    context = CreateLoanInteractor.call(fund: fund,
                                        params: valid_loan_params_with_targeted_pool
      .merge({ institution_id: institution_not_invested.id }), user: administrator)
    expect(context).to be_success
  end

  it 'creates a new valid loan request with general_manager role for a new institution' do
    context = CreateLoanInteractor.call(fund: fund,
                                        params: valid_loan_params
      .merge({ institution_id: institution_not_invested.id }), user: general_manager)
    expect(context).to be_success

    loan = context.loan
    expect(loan.creation_user).to eq(general_manager)
    expect(loan.fund).to eq(fund)
    expect(loan.last_loan_version).to eq(1)
    expect(loan.institution_mode_at_creation).to eq(Loan::NEW_INSTITUTION_MODE)
    loan_version = loan.active_loan_version
    expect(loan_version.status).to eq(LoanVersion::STATUS_ASSIGNED)
    expect(loan_version.version_status).to eq(LoanVersion::VERSION_STATUS_VALIDATED)
    expect(loan_version.creation_user).to eq(general_manager)

    emails = ActionMailer::Base.deliveries
    expect(emails).not_to be_nil
    expect(emails.first.subject).to eq(I18n.t('mailers.loan_creation_without_validation_link.subject', meta: '[test]'))
    expect(emails.map(&:to).flatten).to include(investment_manager.email)
  end

  it 'creates a new valid loan request with investment_manager role for a new institution' do
    params = valid_loan_params.merge({ institution_id: institution_not_invested.id })
    context = CreateLoanInteractor.call(fund: fund, params: params, user: investment_manager)
    expect(context).to be_success

    loan = context.loan
    expect(loan.creation_user).to eq(investment_manager)
    expect(loan.fund).to eq(fund)
    expect(loan.last_loan_version).to eq(1)
    expect(loan.institution_mode_at_creation).to eq(Loan::NEW_INSTITUTION_MODE)
    loan_version = loan.active_loan_version
    expect(loan_version.status).to eq(LoanVersion::STATUS_ASSIGNED)
    expect(loan_version.version_status).to eq(LoanVersion::VERSION_STATUS_VALIDATED)
    expect(loan_version.creation_user).to eq(investment_manager)

    emails = ActionMailer::Base.deliveries
    expect(emails.first.subject).to eq(I18n.t('mailers.loan_creation_with_validation_link.subject', meta: '[test]'))
    expect(emails.map(&:to).flatten).not_to include(investment_manager.email)
    expect(emails.map(&:to).flatten).to include(administrator.email)
  end

  it 'tries to create a new incomplete loan request' do
    context = CreateLoanInteractor.call(fund: fund,
                                        params: incomplete_loan_params
      .merge({ institution_id: institution_not_invested.id }), user: administrator)
    expect(context).not_to be_success
    expect(context.loan.errors).not_to be_empty
    expect(context.loan.active_loan_version.errors).not_to be_empty
  end

  it 'tries to create a loan request with not compliant targeted pool' do
    context = CreateLoanInteractor.call(fund: fund,
                                        params: invalid_loan_params_with_wrong_targeted_pool
      .merge({ institution_id: institution_not_invested.id }), user: administrator)
    expect(context).not_to be_success
    expect(context.loan.active_loan_version.errors).not_to be_empty
  end

  it 'creates a new valid loan with administrator role for an invested institution' do
    context = CreateLoanInteractor.call(fund: fund,
                                        params: valid_loan_params
      .merge({ institution_id: invested_institution.id }), user: administrator)
    expect(context).to be_success

    loan = context.loan
    expect(loan.creation_user).to eq(administrator)
    expect(loan.fund).to eq(fund)
    expect(loan.last_loan_version).to eq(1)
    expect(loan.institution_mode_at_creation).to eq(Loan::INVESTED_INSTITUTION_MODE)
    loan_version = loan.active_loan_version
    expect(loan_version.status).to eq(LoanVersion::STATUS_APPETITE_INQUIRY)
    expect(loan_version.version_status).to eq(LoanVersion::VERSION_STATUS_VALIDATED)
    expect(loan_version.creation_user).to eq(administrator)
  end

  it 'creates a new loan with innpact loan id max incremented by 1' do
    last_innpact_loan_id = Loan.with_deleted.maximum(:innpact_loan_id)
    context = CreateLoanInteractor.call(fund: fund, params: valid_loan_params
                                                  .merge({ institution_id: institution_not_invested.id }), user: administrator)
    expect(context.loan.innpact_loan_id).to eql last_innpact_loan_id + 1
  end
end
