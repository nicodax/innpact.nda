# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RepaymentCalendarLine do
  include_context 'shared factories'

  describe 'self.critical_case?' do
    let(:loan) { create(:loan, fund: fund, institution: institution, im_group: default_im_group) }
    let(:loan_version) { create(:loan_version, :invested, loan: loan, executed_nominal_amount: 100.6) }
    let!(:repayment_calendar) { create(:repayment_calendar, loan_version: loan_version) }
    let(:previous_line) { repayment_calendar.repayment_calendar_lines.first }

    context 'line is not persisted' do
      let(:new_line) do
        build(:repayment_calendar_line, repayment_calendar: repayment_calendar, original_amount: 10)
      end

      it { expect(RepaymentCalendarLine.critical_case?(new_line)).to be_truthy }
    end

    context 'line has changed original_amount' do
      let(:new_line) do
        build(:repayment_calendar_line, repayment_calendar: repayment_calendar, original_amount: 10,
                                        previous_version_line: previous_line)
      end

      it { expect(RepaymentCalendarLine.critical_case?(new_line)).to be_truthy }
    end

    context 'line has changed status' do
      let(:new_line) do
        build(:repayment_calendar_line, repayment_calendar: repayment_calendar,
                                        status: RepaymentCalendarLine::STATUS_UNPAID,
                                        previous_version_line: previous_line)
      end

      it { expect(RepaymentCalendarLine.critical_case?(new_line)).to be_truthy }
    end

    context 'line has changed repayment_date' do
      let(:new_line) do
        build(:repayment_calendar_line, repayment_calendar: repayment_calendar,
                                        repayment_date: Date.today + 2.days,
                                        previous_version_line: previous_line)
      end

      it { expect(RepaymentCalendarLine.critical_case?(new_line)).to be_truthy }
    end

    context 'payment is on time' do
      let(:new_line) do
        build(:repayment_calendar_line, repayment_calendar: repayment_calendar,
                                        status: RepaymentCalendarLine::STATUS_PAID,
                                        received_amount: previous_line.original_amount,
                                        previous_version_line: previous_line)
      end

      it { expect(RepaymentCalendarLine.critical_case?(new_line)).to be_falsey }
    end

    context 'interest type' do
      let(:new_line) do
        build(:repayment_calendar_line, repayment_calendar: repayment_calendar, original_amount: 10,
                                        repayment_type: RepaymentCalendarLine::REPAYMENT_TYPE_INTEREST,
                                        previous_version_line: previous_line)
      end

      it { expect(RepaymentCalendarLine.critical_case?(new_line)).to be_falsey }
    end
  end
end
