# frozen_string_literal: true

require 'rails_helper'

Rails.application.load_tasks

RSpec.describe 'daily_task validation' do
  include_context 'shared factories'
  context 'when there is loan status to update automatically' do
    let!(:system_user) { create(:user) }

    let!(:loan_yesterday) do
      create(:loan, institution_id: institution.id, im_group: default_im_group,
                    innpact_loan_id: rand(1000), last_loan_version: 1, fund: fund,
                    creation_user: investment_manager)
    end
    let!(:loan_tomorrow) do
      create(:loan, institution_id: institution.id, im_group: default_im_group,
                    innpact_loan_id: rand(1000), last_loan_version: 1, fund: fund,
                    creation_user: investment_manager)
    end
    let!(:loan_2_days_ago) do
      create(:loan, institution_id: institution.id, im_group: default_im_group,
                    innpact_loan_id: rand(1000), last_loan_version: 1, fund: fund,
                    creation_user: investment_manager)
    end
    let!(:loan_yesterday_2_versions) do
      create(:loan, institution_id: institution.id, im_group: default_im_group,
                    innpact_loan_id: rand(1000), last_loan_version: 2, fund: fund,
                    creation_user: investment_manager)
    end

    before do
      create(
        :loan_version,
        :invested,
        loan: loan_yesterday,
        version_status: LoanVersion::VERSION_STATUS_VALIDATED,
        version_number: 1,
        validation_user: administrator,
        creation_user: investment_manager,
        maturity_date: Time.zone.today - 1.day,
        approved_bond_id: bond.id,
        approved_interest_rate_type_id: interest_rate_type.id
      )

      create(
        :loan_version,
        :invested,
        loan: loan_tomorrow,
        version_status: LoanVersion::VERSION_STATUS_VALIDATED,
        version_number: 1,
        creation_user: investment_manager,
        validation_user: administrator,
        maturity_date: Time.zone.today + 1.day,
        approved_bond_id: bond.id,
        approved_interest_rate_type_id: interest_rate_type.id
      )

      create(
        :loan_version,
        :invested,
        loan: loan_2_days_ago,
        version_status: LoanVersion::VERSION_STATUS_VALIDATED,
        version_number: 1,
        creation_user: investment_manager,
        validation_user: administrator,
        maturity_date: Time.zone.today - 2.days,
        approved_bond_id: bond.id,
        approved_interest_rate_type_id: interest_rate_type.id
      )

      create(
        :loan_version,
        :invested,
        loan: loan_yesterday_2_versions,
        version_status: LoanVersion::VERSION_STATUS_VALIDATED,
        version_number: 1,
        creation_user: investment_manager,
        validation_user: administrator,
        maturity_date: Time.zone.today - 3.days,
        approved_bond_id: bond.id,
        approved_interest_rate_type_id: interest_rate_type.id
      )

      create(
        :loan_version,
        :invested,
        loan: loan_yesterday_2_versions,
        version_status: LoanVersion::VERSION_STATUS_VALIDATED,
        version_number: 2,
        creation_user: investment_manager,
        validation_user: administrator,
        maturity_date: Time.zone.today - 1.day,
        approved_bond_id: bond.id,
        approved_interest_rate_type_id: interest_rate_type.id
      )

      system_user.add_role(:system)
    end

    it 'validates if the maturity date = today - 1 day' do
      Rake::Task['daily_task:update_status_invested_to_matured'].execute
      new_loan1 = Loan.where(id: loan_yesterday.id).first
      new_loan2 = Loan.where(id: loan_tomorrow.id).first
      new_loan3 = Loan.where(id: loan_2_days_ago.id).first
      new_loan4 = Loan.where(id: loan_yesterday_2_versions.id).first

      expect(new_loan1.last_loan_version).to eq(loan_yesterday.last_loan_version + 1)
      expect(new_loan2.last_loan_version).to eq(loan_tomorrow.last_loan_version)
      expect(new_loan3.last_loan_version).to eq(loan_2_days_ago.last_loan_version)
      expect(new_loan4.last_loan_version).to eq(loan_yesterday_2_versions.last_loan_version + 1)

      expect(new_loan1.matured?).to be(true)
      expect(new_loan2.matured?).to be(false)
      expect(new_loan3.matured?).to be(false)
      expect(new_loan4.matured?).to be(true)
    end

    it 'correctly sent an email to admins and gms' do
      Rake::Task['daily_task:update_status_invested_to_matured'].execute

      emails = ActionMailer::Base.deliveries
      expect(emails).not_to be_nil
      expect(emails.last.subject).to eq(I18n.t('mailers.system_loan_update.subject', meta: '[test]'))
    end
  end

  context 'when an error occured in the loan status update' do
    let!(:bad_loan_yesterday) do
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

    let!(:system_user) { create(:user) }

    before do
      create(
        :loan_version,
        :invested,
        loan: bad_loan_yesterday,
        version_status: LoanVersion::VERSION_STATUS_VALIDATED,
        version_number: 1,
        validation_user: administrator,
        creation_user: investment_manager,
        maturity_date: Time.zone.today - 1.day,
        approved_bond_id: nil,
        approved_interest_rate_type_id: nil
      )
    end

    it 'send an error email to gms and managers' do
      system_user.add_role(:system)
      Rake::Task['daily_task:update_status_invested_to_matured'].execute
      emails = ActionMailer::Base.deliveries
      expect(emails).not_to be_nil
      expect(emails.last.subject).to eq(I18n.t('mailers.system_loan_status_update_failed.subject', meta: '[test]'))
    end
  end
end
