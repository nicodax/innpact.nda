# frozen_string_literal: true

require 'rails_helper'

RSpec.describe LoanVersion do
  include_context 'shared factories'

    describe 'repayment_calendar model tests' do
        let(:maturity_date_past) { Date.today - 1.month }
        let(:maturity_date_futur) { Date.today + 1.month }
        let(:loan) { create(:loan, fund: fund, institution: institution, im_group: default_im_group, last_loan_version: 3) }
        let(:loan_version1) { create(:loan_version, :matured, loan: loan, maturity_date: maturity_date_past, version_number: 1) }
        let(:loan_version2) { create(:loan_version, :invested, loan: loan, maturity_date: nil, version_number: 2) }
        let(:loan_version3) { create(:loan_version, :invested, loan: loan, maturity_date: maturity_date_futur, version_number: 3) }

        it 'test has_maturity_date function' do
            expect(loan_version1.has_maturity_date?).to eq(true)
            expect(loan_version2.has_maturity_date?).to eq(false)
        end

        it 'test invested? function' do
            expect(loan_version1.invested?).to eq(false)
            expect(loan_version2.invested?).to eq(true)
        end

        it 'test matured? function' do
            expect(loan_version1.matured?).to eq(true)
            expect(loan_version2.matured?).to eq(false)
        end

        it 'test maturity_date_is_in_past? function' do
            expect(loan_version1.maturity_date_is_in_past?).to eq(true)
            expect(loan_version2.maturity_date_is_in_past?).to eq(false)
            expect(loan_version3.maturity_date_is_in_past?).to eq(false)
        end

        it 'test maturity_date_is_in_futur? function' do
            expect(loan_version1.maturity_date_is_in_futur?).to eq(false)
            expect(loan_version2.maturity_date_is_in_futur?).to eq(false)
            expect(loan_version3.maturity_date_is_in_futur?).to eq(true)
        end
    end
end
