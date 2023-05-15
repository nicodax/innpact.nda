# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RepaymentCalendar do
  include_context 'shared factories'

    describe 'repayment_calendar model tests' do
        let(:loan) { create(:loan, fund: fund, institution: institution, im_group: default_im_group) }
        let(:loan_version) { create(:loan_version, :invested, loan: loan, executed_nominal_amount: 30, ) }
        let!(:repayment_calendar) { create(:repayment_calendar, loan_version: loan_version, repayment_calendar_lines:[
            build(:repayment_calendar_line, original_amount: 10, received_amount: 0, status: RepaymentCalendarLine::STATUS_PENDING, repayment_date: Date.today + 2.days, id: 1),
            build(:repayment_calendar_line, original_amount: 10, received_amount: 0, status: RepaymentCalendarLine::STATUS_PENDING, repayment_date: Date.today + 4.days, id: 2),
            build(:repayment_calendar_line, original_amount: 10, received_amount: 10, status: RepaymentCalendarLine::STATUS_PAID, repayment_date: Date.today - 2.days, id: 3),
        ]) }

        it 'test get_sorted_repayment_calendar_lines_by_repayment_date_asc' do
            sorted_repayment_calendar_lines = repayment_calendar.get_sorted_repayment_calendar_lines_by_repayment_date_asc
            expect(sorted_repayment_calendar_lines.first.repayment_date).to eq(Date.today - 2.days)
            expect(sorted_repayment_calendar_lines.last.repayment_date).to eq(Date.today + 4.days)
        end

        it 'test get_last_pending_repayment_calendar_line' do
            last_pending_repayment_calendar_line = repayment_calendar.get_last_pending_repayment_calendar_line
            expect(last_pending_repayment_calendar_line.id).to eq(2)
        end
    end
end
