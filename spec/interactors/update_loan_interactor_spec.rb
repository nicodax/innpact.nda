# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UpdateLoanInteractor do
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
    create(:loan, institution_id: institution.id, im_group: default_im_group,
                  innpact_loan_id: rand(1000), last_loan_version: 1, fund: fund,
                  creation_user: investment_manager)
  end

  let!(:loan_version) do
    create(:loan_version, :assigned, loan: loan, status: LoanVersion::STATUS_ASSIGNED,
                                     version_status: LoanVersion::VERSION_STATUS_VALIDATED,
                                     validation_user: administrator)
  end

  let!(:valid_loan_params) do
    {
      institution_id: institution.id,
      im_group_id: default_im_group.id,
      innpact_loan_id: loan.innpact_loan_id,
      loan_sdg_data: {
        no_poverty: false,
        zero_hunger: false,
        good_health_and_wellbeing: false,
        quality_education: false,
        gender_equality: false,
        clean_water_and_sanitation: false,
        affordable_and_clean_energy: false,
        descent_work_and_economic_growth: false,
        industry_innovation_and_infrastructure: false,
        reduced_inequalities: false,
        sustainable_cities_and_conmmunities: false,
        responsible_consumption_and_production: false,
        climate_action: false,
        life_below_water: false,
        life_on_land: false,
        peace_justice_and_strong_institutions: false,
        partnerships_for_the_goals: false
      },
      loan_version: {
        status: LoanVersion::STATUS_RATIFIED,
        pool_id: pool.id,
        expected_disbursement_date: Time.zone.today + rand(100).days,
        probabilities: rand(1000).to_f / 10,
        currency_id: currency2.id,
        loan_type_id: loan_type2.id,
        ratified_nominal_amount: rand(1000).to_f / 10,
        ratified_tenor: rand(100),
        ratified_spread: rand(1000).to_f / 10,
        ratified_upfront_fees: rand(1000).to_f / 10,
        ratified_fixed_rate: rand(1000).to_f / 10,
        ratification_date: Time.zone.today + rand(10).days,
        deadline_ratification_date: Time.zone.today + rand(100).days,
        hedge_comment: 'Test invested hedge',
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
        invested_comment: 'test',
        released_after_approval_comment: 'test',
        not_validated_comment: 'test'
      }
    }
  end

  let!(:incomplete_loan_params) do
    {
      institution_id: institution.id,
      loan_version: {
        status: LoanVersion::STATUS_RATIFIED,
        invested_comment: 'Test invested hedge',
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
        released_after_approval_comment: 'test',
        not_validated_comment: 'test'
      }
    }
  end

  let!(:approved_loan) do
    create(:loan, institution_id: institution.id, im_group: default_im_group,
                  innpact_loan_id: rand(1000), last_loan_version: 1, fund: fund,
                  creation_user: investment_manager)
  end

  let!(:approved_loan_version) do
    create(:loan_version, :approved, loan: approved_loan, status: LoanVersion::STATUS_APPROVED,
                                     version_status: LoanVersion::VERSION_STATUS_VALIDATED,
                                     validation_user: administrator, creation_user: investment_manager)
  end

  let!(:valid_invested_loan_params) do
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
        not_validated_comment: 'test',
        invested_hedge_fx_rate: 1
      },
      repayment_calendar:
      {
        repayment_calendar_lines_attributes: {
          '0': {
            repayment_date: Time.zone.today + rand(100).days,
            repayment_type: RepaymentCalendarLine::REPAYMENT_TYPE_PRINCIPAL,
            original_amount: 1000
          }
        }
      }
    }
  end

  let!(:valid_invested_loan_params_with_provision) do
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
        invested_comment: 'test',
        released_after_approval_comment: 'test',
        not_validated_comment: 'test',
        invested_hedge_fx_rate: 1
      },
      repayment_calendar: {
        repayment_calendar_lines_attributes: {
          '0': {
            repayment_date: Time.zone.today + rand(100).days,
            repayment_type: RepaymentCalendarLine::REPAYMENT_TYPE_PRINCIPAL,
            original_amount: 1000,
            provision: 100
          }
        }
      }
    }
  end

  let!(:invested_loan_params_with_invalid_calendar) do
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
        invested_comment: 'test',
        released_after_approval_comment: 'test',
        not_validated_comment: 'test',
        invested_hedge_fx_rate: 1
      },
      repayment_calendar: {
        repayment_calendar_lines_attributes: {
          '0': {
            repayment_date: Time.zone.today + rand(100).days,
            repayment_type: RepaymentCalendarLine::REPAYMENT_TYPE_PRINCIPAL,
            original_amount: 200
          }
        }
      }
    }
  end

  it 'lets an administrator do a valid update on a loan' do
    loan.reload
    context = described_class.call(loan: loan, params: valid_loan_params, user: administrator)
    expect(context).to be_success

    new_loan = loan.reload
    expect(new_loan.last_loan_version).to eq(2)
    expect(new_loan.loan_versions.size).to eq(2)
    new_loan_version = loan.active_loan_version
    expect(new_loan_version.status).to eq(LoanVersion::STATUS_RATIFIED)
    expect(new_loan_version.version_status).to eq(LoanVersion::VERSION_STATUS_VALIDATED)
    expect(new_loan_version.validation_user).to eq(administrator)
    expect(new_loan_version.creation_user).to eq(administrator)

    emails = ActionMailer::Base.deliveries
    expect(emails).not_to be_nil
    expect(emails.first.subject).to eq(I18n.t('mailers.loan_update_without_validation_link.subject', meta: '[test]'))
    expect(emails.map(&:to).flatten).not_to include(administrator.email)
  end

  it 'lets an general_manager do a valid update on a loan' do
    loan.reload
    context = described_class.call(loan: loan, params: valid_loan_params, user: general_manager)
    expect(context).to be_success

    new_loan = loan.reload
    expect(new_loan.last_loan_version).to eq(2)
    # expect(new_loan.loan_versions.size).to eq(2)
    new_loan_version = loan.active_loan_version
    expect(new_loan_version.status).to eq(LoanVersion::STATUS_RATIFIED)
    expect(new_loan_version.version_status).to eq(LoanVersion::VERSION_STATUS_VALIDATED)
    expect(new_loan_version.validation_user).to eq(general_manager)
    expect(new_loan_version.creation_user).to eq(general_manager)

    emails = ActionMailer::Base.deliveries
    expect(emails).not_to be_nil
    expect(emails.first.subject).to eq(I18n.t('mailers.loan_update_without_validation_link.subject', meta: '[test]'))
    expect(emails.map(&:to).flatten).not_to include(general_manager.email)
    expect(emails.map(&:to).flatten).to include(administrator.email)
  end

  it 'lets an investment_manager do a valid update on a loan' do
    loan.reload
    context = described_class.call(loan: loan, params: valid_loan_params, user: investment_manager)
    expect(context).to be_success

    new_loan = loan.reload
    expect(new_loan.last_loan_version).to eq(2)
    expect(new_loan.loan_versions.size).to eq(2)
    new_loan_version = loan.active_loan_version
    expect(new_loan_version.status).to eq(LoanVersion::STATUS_RATIFIED)
    expect(new_loan_version.version_status).to eq(LoanVersion::VERSION_STATUS_TEMPORARY)
    expect(new_loan_version.validation_user).to be_falsey
    expect(new_loan_version.creation_user).to eq(investment_manager)

    emails = ActionMailer::Base.deliveries
    expect(emails).not_to be_nil
    expect(emails.first.subject).to eq(I18n.t('mailers.loan_update_with_validation_link.subject', meta: '[test]'))
    expect(emails.map(&:to).flatten).not_to include(investment_manager.email)
    expect(emails.map(&:to).flatten).to include(administrator.email)
  end

  it 'updates a loan with invalid params' do
    loan.reload
    context = described_class.call(loan: loan, params: incomplete_loan_params, user: administrator)
    expect(context).not_to be_success
    expect(context.loan.active_loan_version.errors).not_to be_empty
    expect(context.error).to include(
      'Ratified nominal amount must be filled',
      'Ratified tenor must be filled',
      'Ratified spread must be filled',
      'Ratified upfront fees must be filled',
      'Ratified fixed rate must be filled',
      'Ratification date must be filled',
      'Deadline ratification date must be filled'
    )
  end

  it 'updates to invested status' do
    approved_loan.reload
    context = described_class.call(loan: approved_loan, params: valid_invested_loan_params, user: administrator)
    expect(context).to be_success

    new_loan = approved_loan.reload
    expect(new_loan.last_loan_version).to eq(2)
    expect(new_loan.loan_versions.size).to eq(2)
    new_loan_version = new_loan.active_loan_version
    expect(new_loan_version.status).to eq(LoanVersion::STATUS_INVESTED)
    expect(new_loan_version.version_status).to eq(LoanVersion::VERSION_STATUS_VALIDATED)
    expect(new_loan_version.validation_user).to eq(administrator)
    expect(new_loan_version.creation_user).to eq(administrator)
    repayment_calendar = new_loan_version.repayment_calendar
    expect(repayment_calendar.repayment_calendar_lines.size).to eq(1)
    expect(repayment_calendar.calendar_log).to be_truthy
    expect(repayment_calendar.calendar_log.lines.size).to eq(1)

    emails = ActionMailer::Base.deliveries
    expect(emails).not_to be_nil
    expect(emails.first.subject).to eq(I18n.t('mailers.loan_update_without_validation_link.subject', meta: '[test]'))
    expect(emails.map(&:to).flatten).not_to include(administrator.email)
  end

  it 'creates a loan provision if provision present in repayment calendar' do
    approved_loan.reload
    context = described_class.call(
      loan: approved_loan,
      params: valid_invested_loan_params_with_provision,
      user: administrator
    )
    expect(context).to be_success

    new_loan = approved_loan.reload
    new_calendar = new_loan.active_repayment_calendar
    loan_provision = new_loan.loan_provisions.first

    expect(loan_provision.repayment_calendar).to eq(new_calendar)
    expect(loan_provision.amount).to eq(100)
    expect(loan_provision.previous_amount_of_provision).to eq(0)
    expect(loan_provision.new_amount_of_provision).to eq(100)
    expect(loan_provision.institution_provision_id).to be_falsey
    expect(loan_provision.creation_user).to eq(administrator)
  end

  it 'does not update loan if calendar does not add up' do
    approved_loan.reload
    context = described_class.call(
      loan: approved_loan,
      params: invested_loan_params_with_invalid_calendar,
      user: administrator
    )
    expect(context).not_to be_success
    expect(context.loan.active_loan_version.repayment_calendar.errors).not_to be_empty
    expect(context.error).not_to be_empty
  end

  context 'when change to invested state and use institution provision' do
    let!(:approved_loan) do
      create(
        :loan,
        institution_id: institution.id,
        im_group: default_im_group,
        innpact_loan_id: rand(1000),
        last_loan_version: 1,
        fund: fund,
        creation_user: investment_manager
      )
    end

    let!(:approved_loan_version) do
      create(
        :loan_version,
        :approved,
        loan: approved_loan,
        status: LoanVersion::STATUS_APPROVED,
        version_status: LoanVersion::VERSION_STATUS_VALIDATED,
        validation_user: administrator,
        creation_user: investment_manager
      )
    end

    let!(:valid_invested_loan_params_without_provision) do
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
          net_position_value: 1000,
          gross_position_value: 1000,
          loan_interest_rate_type_id: interest_rate_type.id,
          approved_interest_rate_type_id: interest_rate_type.id,
          hedge_comment: 'Test invested hedge',
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
          invested_comment: 'test',
          released_after_approval_comment: 'test',
          not_validated_comment: 'test',
          invested_hedge_fx_rate: 1
        },
        repayment_calendar: {
          repayment_calendar_lines_attributes: {
            '0': {
              repayment_date: Time.zone.today + rand(100).days,
              repayment_type: RepaymentCalendarLine::REPAYMENT_TYPE_PRINCIPAL,
              original_amount: 1000,
              provision: 0
            }
          }
        }
      }
    end

    before do
      create(
        :institution_provision,
        institution: institution,
        creation_user: administrator,
        version_status: InstitutionProvision::VERSION_STATUS_VALIDATED,
        percentage: 0.15
      )
    end

    it 'uses institution\'s provision to calculate a valid gross_position_value' do
      approved_loan.reload
      context = described_class.call(
        loan: approved_loan,
        params: valid_invested_loan_params_without_provision,
        user: administrator
      )
      expect(context).to be_success
      expect(context.loan.provision_value).to eq(150)
      expect(context.loan.net_position_value).to eq(850)
    end

    it 'updates to invested status with invested hedge comment' do
      approved_loan.reload
      context = described_class.call(loan: approved_loan, params: valid_invested_loan_params, user: administrator)
      expect(context).to be_success

      new_loan = approved_loan.reload
      expect(new_loan.hedge_comment).to eq('Test invested hedge')
    end

    it 'fails the update to invested status when the invested hedge is greater than 100 characters' do
      valid_invested_loan_params[:loan_version][:hedge_comment] = 'a' * 150
      approved_loan.reload
      context = described_class.call(loan: approved_loan, params: valid_invested_loan_params, user: administrator)
      expect(context).not_to be_success
      expect(context.loan.active_loan_version.errors.messages[:hedge_comment]).to eql(
        ['size cannot be greater than 100']
      )
      expect(context.error).to include(
        'Hedge comment size cannot be greater than 100'
      )
    end

    it 'updates to invested status with invested comment' do
      approved_loan.reload
      context = described_class.call(loan: approved_loan, params: valid_invested_loan_params, user: administrator)
      expect(context).to be_success

      new_loan = approved_loan.reload
      expect(new_loan.invested_comment).to eq('Invested comment')
    end

    it 'fails the update to invested status when the invested comment is greater than 1000 characters' do
      approved_loan.reload
      valid_invested_loan_params[:loan_version][:invested_comment] = 'a' * 1100
      context = described_class.call(loan: approved_loan, params: valid_invested_loan_params, user: administrator)
      expect(context).not_to be_success
      expect(context.loan.active_loan_version.errors.messages[:invested_comment]).to eql(
        ['size cannot be greater than 1000']
      )
      expect(context.error).to include(
        'Invested comment size cannot be greater than 1000'
      )
    end

    it 'fails the update to invested status when loan_spread is not filled' do
      valid_invested_loan_params[:loan_version][:loan_spread] = nil
      context = described_class.call(loan: approved_loan, params: valid_invested_loan_params, user: administrator)
      expect(context).not_to be_success
      expect(context.loan.active_loan_version.errors.messages[:loan_spread]).to eql(["must be filled"])
    end

    it 'fails the update to invested status when loan_interest_rate_type_id is not filled' do
      valid_invested_loan_params[:loan_version][:loan_interest_rate_type_id] = nil
      context = described_class.call(loan: approved_loan, params: valid_invested_loan_params, user: administrator)
      expect(context).not_to be_success
      expect(context.loan.active_loan_version.errors.messages[:loan_interest_rate_type_id]).to eql(["must be filled"])
    end

    it 'fails the update to invested status when hedge_spread is fill but not hedge_interest_rate_type_id' do
      valid_invested_loan_params[:loan_version][:hedge_spread] = rand(1000).to_f / 10
      valid_invested_loan_params[:loan_version][:hedge_interest_rate_type_id] = nil
      context = described_class.call(loan: approved_loan, params: valid_invested_loan_params, user: administrator)
      expect(context).not_to be_success
      expect(context.loan.active_loan_version.errors.messages[:loan]).to eql(["hedge interest rate type cannot be empty"])
    end

    it 'fails the update to invested status when hedge_interest_rate_type_id is fill but not hedge_spread' do
      valid_invested_loan_params[:loan_version][:hedge_spread] = nil
      valid_invested_loan_params[:loan_version][:hedge_interest_rate_type_id] = 1
      context = described_class.call(loan: approved_loan, params: valid_invested_loan_params, user: administrator)
      expect(context).not_to be_success
      expect(context.loan.active_loan_version.errors.messages[:loan]).to eql(["hedge spread cannot be empty"])
    end
  end
end
