# frozen_string_literal: true

require 'rails_helper'

RSpec.describe LoanDecorator do
  subject(:loan_subject) { described_class.decorate(invested_loan) }

  include_context 'shared factories'

  let!(:invested_institution) { create(:institution, fund: fund, im_group: default_im_group) }
  let!(:invested_loan) do
    create(:loan,
           fund: fund,
           institution: invested_institution,
           creation_user: general_manager,
           im_group: default_im_group)
  end

  let(:deleted_loan) do
    create(:loan,
           fund: fund,
           institution: invested_institution,
           creation_user: general_manager,
           im_group: default_im_group,
           deleted_at: Time.zone.today)
  end

  let!(:interest_rate_type_for_loan) do
    create(:interest_rate_type)
  end

  let!(:interest_rate_type_for_hedge) do
    create(:interest_rate_type)
  end

  it 'test dashboard_path and dashboard_path _name with deleted loan' do
    deleted_loan_decorator = described_class.decorate(deleted_loan)
    expect(deleted_loan_decorator.dashboard_path).to eq("/funds/#{fund.id}/deleted_loans")
    expect(deleted_loan_decorator.dashboard_path_name).to eq(I18n.t('.breadcrumbs.loan_deleted'))
  end

  it 'test dashboard_path and dashboard_path _name with loan_version status assigned' do
    create(:loan_version, :invested, loan: invested_loan, creation_user: general_manager, status: LoanVersion::STATUS_ASSIGNED)
    loan_subject.reload
    expect(loan_subject.dashboard_path).to eq("/funds/#{fund.id}/loan_request_dashboard")
    expect(loan_subject.dashboard_path_name).to eq(I18n.t('.breadcrumbs.loan_requests'))
  end

  it 'test dashboard_path and dashboard_path _name with loan_version status appetite_inquiry' do
    create(:loan_version, :invested, loan: invested_loan, creation_user: general_manager, status: LoanVersion::STATUS_APPETITE_INQUIRY)
    loan_subject.reload
    expect(loan_subject.dashboard_path).to eq("/funds/#{fund.id}/loan_request_dashboard")
    expect(loan_subject.dashboard_path_name).to eq(I18n.t('.breadcrumbs.loan_requests'))
  end

  it 'test dashboard_path and dashboard_path _name with loan_version status pending_ratification' do
    create(:loan_version, :invested, loan: invested_loan, creation_user: general_manager, status: LoanVersion::STATUS_PENDING_RATIFICATION)
    loan_subject.reload
    expect(loan_subject.dashboard_path).to eq("/funds/#{fund.id}/loan_request_dashboard")
    expect(loan_subject.dashboard_path_name).to eq(I18n.t('.breadcrumbs.loan_requests'))
  end

  it 'test dashboard_path and dashboard_path _name with loan_version status ratified' do
    create(:loan_version, :invested, loan: invested_loan, creation_user: general_manager, status: LoanVersion::STATUS_RATIFIED)
    loan_subject.reload
    expect(loan_subject.dashboard_path).to eq("/funds/#{fund.id}/loan_request_dashboard")
    expect(loan_subject.dashboard_path_name).to eq(I18n.t('.breadcrumbs.loan_requests'))
  end

  it 'test dashboard_path and dashboard_path _name with loan_version status not_ratified' do
    create(:loan_version, :invested, loan: invested_loan, creation_user: general_manager, status: LoanVersion::STATUS_NOT_RATIFIED)
    loan_subject.reload
    expect(loan_subject.dashboard_path).to eq("/funds/#{fund.id}/accepted_loan_dashboard")
    expect(loan_subject.dashboard_path_name).to eq(I18n.t('.breadcrumbs.loan_accepted'))
  end

  it 'test dashboard_path and dashboard_path _name with loan_version status assignment_expired' do
    create(:loan_version, :invested, loan: invested_loan, creation_user: general_manager, status: LoanVersion::STATUS_ASSIGNMENT_EXPIRED)
    loan_subject.reload
    expect(loan_subject.dashboard_path).to eq("/funds/#{fund.id}/accepted_loan_dashboard")
    expect(loan_subject.dashboard_path_name).to eq(I18n.t('.breadcrumbs.loan_accepted'))
  end

  it 'test dashboard_path and dashboard_path _name with loan_version status released_before_approval' do
    create(:loan_version, :invested, loan: invested_loan, creation_user: general_manager, status: LoanVersion::STATUS_RELEASED_BEFORE_APPROVAL)
    loan_subject.reload
    expect(loan_subject.dashboard_path).to eq("/funds/#{fund.id}/accepted_loan_dashboard")
    expect(loan_subject.dashboard_path_name).to eq(I18n.t('.breadcrumbs.loan_accepted'))
  end

  it 'test dashboard_path and dashboard_path _name with loan_version status pending_approval' do
    create(:loan_version, :invested, loan: invested_loan, creation_user: general_manager, status: LoanVersion::STATUS_PENDING_APPROVAL)
    loan_subject.reload
    expect(loan_subject.dashboard_path).to eq("/funds/#{fund.id}/loan_request_dashboard")
    expect(loan_subject.dashboard_path_name).to eq(I18n.t('.breadcrumbs.loan_requests'))
  end

  it 'test dashboard_path and dashboard_path _name with loan_version status approved' do
    create(:loan_version, :invested, loan: invested_loan, creation_user: general_manager, status: LoanVersion::STATUS_APPROVED)
    loan_subject.reload
    expect(loan_subject.dashboard_path).to eq("/funds/#{fund.id}/loan_request_dashboard")
    expect(loan_subject.dashboard_path_name).to eq(I18n.t('.breadcrumbs.loan_requests'))
  end

  it 'test dashboard_path and dashboard_path _name with loan_version status not_approved' do
    create(:loan_version, :invested, loan: invested_loan, creation_user: general_manager, status: LoanVersion::STATUS_NOT_APPROVED)
    loan_subject.reload
    expect(loan_subject.dashboard_path).to eq("/funds/#{fund.id}/accepted_loan_dashboard")
    expect(loan_subject.dashboard_path_name).to eq(I18n.t('.breadcrumbs.loan_accepted'))
  end

  it 'test dashboard_path and dashboard_path _name with loan_version status approval_expired' do
    create(:loan_version, :invested, loan: invested_loan, creation_user: general_manager, status: LoanVersion::STATUS_APPROVAL_EXPIRED)
    loan_subject.reload
    expect(loan_subject.dashboard_path).to eq("/funds/#{fund.id}/accepted_loan_dashboard")
    expect(loan_subject.dashboard_path_name).to eq(I18n.t('.breadcrumbs.loan_accepted'))
  end

  it 'test dashboard_path and dashboard_path _name with loan_version status approved_change_request' do
    create(:loan_version, :invested, loan: invested_loan, creation_user: general_manager, status: LoanVersion::STATUS_APPROVED_CHANGE_REQUEST)
    loan_subject.reload
    expect(loan_subject.dashboard_path).to eq("/funds/#{fund.id}/loan_request_dashboard")
    expect(loan_subject.dashboard_path_name).to eq(I18n.t('.breadcrumbs.loan_requests'))
  end

  it 'test dashboard_path and dashboard_path _name with loan_version status invested' do
    create(:loan_version, :invested, loan: invested_loan, creation_user: general_manager, status: LoanVersion::STATUS_INVESTED)
    loan_subject.reload
    expect(loan_subject.dashboard_path).to eq("/funds/#{fund.id}/accepted_loan_dashboard")
    expect(loan_subject.dashboard_path_name).to eq(I18n.t('.breadcrumbs.loan_accepted'))
  end

  it 'test dashboard_path and dashboard_path _name with loan_version status released_after_approval' do
    create(:loan_version, :invested, loan: invested_loan, creation_user: general_manager, status: LoanVersion::STATUS_RELEASED_AFTER_APPROVAL)
    loan_subject.reload
    expect(loan_subject.dashboard_path).to eq("/funds/#{fund.id}/accepted_loan_dashboard")
    expect(loan_subject.dashboard_path_name).to eq(I18n.t('.breadcrumbs.loan_accepted'))
  end

  it 'test dashboard_path and dashboard_path _name with loan_version status not_validated' do
    create(:loan_version, :invested, loan: invested_loan, creation_user: general_manager, status: LoanVersion::STATUS_NOT_VALIDATED)
    loan_subject.reload
    expect(loan_subject.dashboard_path).to eq("/funds/#{fund.id}/accepted_loan_dashboard")
    expect(loan_subject.dashboard_path_name).to eq(I18n.t('.breadcrumbs.loan_accepted'))
  end

  it 'test dashboard_path and dashboard_path _name with loan_version status matured' do
    create(:loan_version, :invested, loan: invested_loan, creation_user: general_manager, status: LoanVersion::STATUS_MATURED)
    loan_subject.reload
    expect(loan_subject.dashboard_path).to eq("/funds/#{fund.id}/matured_loan_dashboard")
    expect(loan_subject.dashboard_path_name).to eq(I18n.t('.breadcrumbs.loan_matured'))
  end

  it 'return the institution watchlist_entry_date when provision_date or restructuring date are nil' do
    date = Time.zone.now
    invested_institution.watchlist_entry_date = date
    expect(LoanDecorator.decorate(invested_loan).date_of_entry).to eql date.to_date
  end

  context "when changing automatically the executed values of the interactor's methods for loans" do
    before do
      create(
        :loan_version,
        :invested,
        loan: invested_loan,
        status: LoanVersion::STATUS_INVESTED,
        version_status: LoanVersion::VERSION_STATUS_VALIDATED,
        validation_user: administrator,
        loan_interest_rate_type_id: interest_rate_type_for_loan.id
      )
    end

    it 'return the loan_spread value for the executed_spread' do
      invested_loan.active_loan_version.loan_spread = 30
      invested_loan.active_loan_version.hedge_spread = nil
      expect(LoanDecorator.decorate(invested_loan).formatted_executed_spread).to eql '30.00%'
    end

    it 'return the hedge_spread value for the executed_spread' do
      invested_loan.active_loan_version.loan_spread = 30
      invested_loan.active_loan_version.hedge_spread = 50
      expect(LoanDecorator.decorate(invested_loan).formatted_executed_spread).to eql '50.00%'
    end

    it 'return the loan_interest_rate_type value for the executed_interest_rate_type' do
      invested_loan.active_loan_version.hedge_interest_rate_type_id = nil
      expect(LoanDecorator.decorate(invested_loan).executed_rate_type_name).to eql interest_rate_type_for_loan.name
    end

    it 'return the hedge_interest_rate_type value for the executed_interest_rate_type' do
      invested_loan.active_loan_version.hedge_interest_rate_type_id = interest_rate_type_for_hedge.id
      expect(LoanDecorator.decorate(invested_loan).executed_rate_type_name).to eql interest_rate_type_for_hedge.name
    end
  end
end
