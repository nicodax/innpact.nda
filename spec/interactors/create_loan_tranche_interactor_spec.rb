# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CreateLoanTrancheInteractor do
  include_context 'shared factories'

  let!(:currency_1) { create(:currency, fund: fund) }
  let!(:currency_2) { create(:currency, fund: fund) }
  let!(:pool) { create(:pool, fund: fund) }
  let!(:bond) { create(:bond, fund: fund) }
  let!(:interest_rate_type) { create(:interest_rate_type, fund: fund) }
  let!(:loan_type_1) { create(:loan_type, fund: fund) }
  let!(:loan_type_2) { create(:loan_type, fund: fund) }
  let!(:repayment_type_1) { create(:repayment_type, fund: fund) }
  let!(:repayment_type_2) { create(:repayment_type, fund: fund) }

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

  subject { CreateLoanTrancheInteractor.call(loan: loan) }

  it 'succeeds' do
    expect(subject).to be_success
  end

  it 'has 2 loans after creating a new tranche' do
    subject
    expect(Loan.all.size).to eql 2
  end

  it 'has the original id the same as the loan copied' do
    subject
    copied_loan = Loan.last
    expect(copied_loan.original_loan_id).to eql loan.id
  end

  it 'has a child at the original loan' do
    subject
    expect(loan.parent_loan?).to eql true
  end

  it 'has one tranche at the original loan' do
    subject
    expect(loan.nb_tranches).to eql 1
  end

  it 's a child' do
    subject
    copied_loan = Loan.last
    expect(copied_loan.is_children?).to eql true
  end

  it 'has the innpact loan id incremented by 1 of the copied loan' do
    subject
    copied_loan = Loan.last
    expect(copied_loan.innpact_loan_id).to eql loan.innpact_loan_id + 1
  end

end
