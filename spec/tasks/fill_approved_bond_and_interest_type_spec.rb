# frozen_string_literal: true

require 'rails_helper'

Rails.application.load_tasks

RSpec.describe 'fill_approved_bond_and_interest_type:fill task validation' do # rubocop:disable RSpec/DescribeClass
  include_context 'shared factories'

  context 'when loan version approved_bond_id and approved_interest_rate_type_id are nil with invested status' do
    let!(:loan1) do
      create(
        :loan,
        innpact_loan_id: rand(1000),
        last_loan_version: 1,
        fund: fund,
        creation_user: investment_manager
      )
    end

    let!(:loan_version1) do
      create(
        :loan_version,
        :invested,
        loan: loan1,
        version_number: 1,
        validation_user: administrator,
        creation_user: investment_manager,
        executed_bond_id: 1,
        loan_interest_rate_type_id: 1,
        approved_bond_id: nil,
        approved_interest_rate_type_id: nil
      )
    end

    it 'check if approved_interest_rate_type_id = executed_interest_rate_type_id' do
      Rake::Task['fill_approved_bond_and_interest_type:fill'].execute
      loan1.reload
      loan_version1.reload
      expect(loan_version1.approved_interest_rate_type_id).to eq(1)
    end

    it 'check if approved_bond_id = executed_bond_id' do
      Rake::Task['fill_approved_bond_and_interest_type:fill'].execute
      loan_version1.reload
      expect(loan_version1.approved_bond_id).to eq(1)
    end
  end

  context 'when loan version approved_bond_id and approved_interest_rate_type_id are nil with approved status' do
    let!(:loan1) do
      create(
        :loan,
        innpact_loan_id: rand(1000),
        last_loan_version: 1,
        fund: fund,
        creation_user: investment_manager
      )
    end

    let!(:loan_version1) do
      create(
        :loan_version,
        :approved,
        loan: loan1,
        version_number: 1,
        validation_user: administrator,
        creation_user: investment_manager,
        executed_bond_id: 1,
        loan_interest_rate_type_id: 1,
        approved_bond_id: nil,
        approved_interest_rate_type_id: nil
      )
    end

    it 'check if approved_interest_rate_type_id = loan_interest_rate_type_id' do
      Rake::Task['fill_approved_bond_and_interest_type:fill'].execute
      loan_version1.reload
      expect(loan_version1.approved_interest_rate_type_id).to eq(1)
    end

    it 'check if approved_bond_id = executed_bond_id' do
      Rake::Task['fill_approved_bond_and_interest_type:fill'].execute
      loan_version1.reload
      expect(loan_version1.approved_bond_id).to eq(1)
    end

    it 'delete executed_bond_id if approved_bond_id = executed_bond_id' do
      Rake::Task['fill_approved_bond_and_interest_type:fill'].execute
      loan_version1.reload
      expect(loan_version1.executed_bond_id).to be_nil
    end

    it 'delete loan_interest_rate_type_id if approved_interest_rate_type_id = loan_interest_rate_type_id' do
      Rake::Task['fill_approved_bond_and_interest_type:fill'].execute
      loan_version1.reload
      expect(loan_version1.loan_interest_rate_type_id).to be_nil
    end
  end

  context 'when loan version approved_bond_id and approved_interest_rate_type_id are nil with matured status' do
    let!(:loan1) do
      create(
        :loan,
        innpact_loan_id: rand(1000),
        last_loan_version: 1,
        fund: fund,
        creation_user: investment_manager
      )
    end

    let!(:loan_version1) do
      create(
        :loan_version,
        :matured,
        loan: loan1,
        version_number: 1,
        validation_user: administrator,
        creation_user: investment_manager,
        executed_bond_id: 1,
        loan_interest_rate_type_id: 1,
        approved_bond_id: nil,
        approved_interest_rate_type_id: nil
      )
    end

    it 'check if approved_interest_rate_type_id = loan_interest_rate_type_id' do
      Rake::Task['fill_approved_bond_and_interest_type:fill'].execute
      loan1.reload
      loan_version1.reload
      expect(loan_version1.approved_interest_rate_type_id).to eq(1)
    end

    it 'check if approved_bond_id = executed_bond_id' do
      Rake::Task['fill_approved_bond_and_interest_type:fill'].execute
      loan_version1.reload
      expect(loan_version1.approved_bond_id).to eq(1)
    end
  end

  context 'when loan version approved_bond_id != executed_bond_id and approved_interest_rate_type_id != loan_interest_rate_type_id with approved status' do
    let!(:loan1) do
      create(
        :loan,
        innpact_loan_id: rand(1000),
        last_loan_version: 1,
        fund: fund,
        creation_user: investment_manager
      )
    end

    let!(:loan_version1) do
      create(
        :loan_version,
        :approved,
        loan: loan1,
        version_number: 1,
        validation_user: administrator,
        creation_user: investment_manager,
        executed_bond_id: 1,
        loan_interest_rate_type_id: 1,
        approved_bond_id: 2,
        approved_interest_rate_type_id: 2
      )
    end

    it 'doesn t delete executed_bond_id if approved_bond_id != executed_bond_id' do
      Rake::Task['fill_approved_bond_and_interest_type:fill'].execute
      loan_version1.reload
      expect(loan_version1.executed_bond_id).not_to be_nil
    end

    it 'doesn t delete loan_interest_rate_type_id if approved_interest_rate_type_id != loan_interest_rate_type_id' do
      Rake::Task['fill_approved_bond_and_interest_type:fill'].execute
      loan_version1.reload
      expect(loan_version1.loan_interest_rate_type_id).not_to be_nil
    end
  end

  context 'when loan version approved_bond_id != nil and approved_interest_rate_type_id != nill with invested status' do
    let!(:loan1) do
      create(
        :loan,
        innpact_loan_id: rand(1000),
        last_loan_version: 1,
        fund: fund,
        creation_user: investment_manager
      )
    end

    let!(:loan_version1) do
      create(
        :loan_version,
        :invested,
        loan: loan1,
        version_number: 1,
        validation_user: administrator,
        creation_user: investment_manager,
        executed_bond_id: 1,
        loan_interest_rate_type_id: 1,
        approved_bond_id: 2,
        approved_interest_rate_type_id: 2
      )
    end

    it 'doesn t change the loan version' do
      old_loan_version = loan_version1
      Rake::Task['fill_approved_bond_and_interest_type:fill'].execute
      loan_version1.reload
      expect(old_loan_version).to eq(loan_version1)
    end
  end

  context 'when loan version approved_bond_id != nil and approved_interest_rate_type_id != nill with matured status' do
    let!(:loan1) do
      create(
        :loan,
        innpact_loan_id: rand(1000),
        last_loan_version: 1,
        fund: fund,
        creation_user: investment_manager
      )
    end

    let!(:loan_version1) do
      create(
        :loan_version,
        :matured,
        loan: loan1,
        version_number: 1,
        validation_user: administrator,
        creation_user: investment_manager,
        executed_bond_id: 1,
        loan_interest_rate_type_id: 1,
        approved_bond_id: 2,
        approved_interest_rate_type_id: 2
      )
    end

    it 'doesn t change the loan version' do
      old_loan_version = loan_version1
      Rake::Task['fill_approved_bond_and_interest_type:fill'].execute
      loan_version1.reload
      expect(old_loan_version).to eq(loan_version1)
    end
  end

  context 'when loan version approved_bond_id == nil and approved_interest_rate_type_id == nill with approved status' do
    let!(:loan1) do
      create(
        :loan,
        innpact_loan_id: rand(1000),
        last_loan_version: 1,
        fund: fund,
        creation_user: investment_manager
      )
    end

    let!(:loan_version1) do
      create(
        :loan_version,
        :approved,
        loan: loan1,
        version_number: 1,
        validation_user: administrator,
        creation_user: investment_manager,
        executed_bond_id: nil,
        loan_interest_rate_type_id: nil,
        approved_bond_id: nil,
        approved_interest_rate_type_id: nil
      )
    end

    it 'doesn t change the loan version' do
      old_loan_version = loan_version1
      Rake::Task['fill_approved_bond_and_interest_type:fill'].execute
      loan_version1.reload
      expect(old_loan_version).to eq(loan_version1)
    end
  end

  context 'when loan version approved_bond_id == nil and approved_interest_rate_type_id == nill with invested status' do
    let!(:loan1) do
      create(
        :loan,
        innpact_loan_id: rand(1000),
        last_loan_version: 1,
        fund: fund,
        creation_user: investment_manager
      )
    end

    let!(:loan_version1) do
      create(
        :loan_version,
        :invested,
        loan: loan1,
        version_number: 1,
        validation_user: administrator,
        creation_user: investment_manager,
        executed_bond_id: nil,
        loan_interest_rate_type_id: 1,
        approved_bond_id: nil,
        approved_interest_rate_type_id: nil
      )
    end

    it 'doesn t change the loan version' do
      old_loan_version = loan_version1
      Rake::Task['fill_approved_bond_and_interest_type:fill'].execute
      loan_version1.reload
      expect(old_loan_version).to eq(loan_version1)
    end
  end

  context 'when loan version approved_bond_id == nil and approved_interest_rate_type_id == nill with matured status' do
    let!(:loan1) do
      create(
        :loan,
        innpact_loan_id: rand(1000),
        last_loan_version: 1,
        fund: fund,
        creation_user: investment_manager
      )
    end

    let!(:loan_version1) do
      create(
        :loan_version,
        :matured,
        loan: loan1,
        version_number: 1,
        validation_user: administrator,
        creation_user: investment_manager,
        executed_bond_id: nil,
        loan_interest_rate_type_id: 1,
        approved_bond_id: nil,
        approved_interest_rate_type_id: nil
      )
    end

    it 'doesn t change the loan version' do
      old_loan_version = loan_version1
      Rake::Task['fill_approved_bond_and_interest_type:fill'].execute
      loan_version1.reload
      expect(old_loan_version).to eq(loan_version1)
    end
  end
end
