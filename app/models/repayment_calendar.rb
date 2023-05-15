# frozen_string_literal: true

class RepaymentCalendar < ApplicationRecord
  acts_as_paranoid # soft delete

  belongs_to :loan_version
  belongs_to :creation_user, class_name: 'User'
  belongs_to :validation_user, class_name: 'User', optional: true
  belongs_to :rejection_user, class_name: 'User', optional: true

  has_many :repayment_calendar_lines, dependent: :destroy
  has_many :principal_repayment_lines, -> {
                                         principal
                                       }, class_name: 'RepaymentCalendarLine', inverse_of: :repayment_calendar
  has_many :interest_repayment_lines, -> {
                                        interest
                                      }, class_name: 'RepaymentCalendarLine', inverse_of: :repayment_calendar

  has_many :loan_provisions, dependent: :destroy
  has_one :calendar_log

  validates_presence_of :repayment_calendar_lines

  validate :principal_repayments_equal_executed_nominal_amount

  accepts_nested_attributes_for :repayment_calendar_lines
  accepts_nested_attributes_for :principal_repayment_lines
  accepts_nested_attributes_for :interest_repayment_lines

  scope :with_version_number, ->(version_number) { where(version_number: version_number) }
  scope :validated, -> { where(version_status: VERSION_STATUS_VALIDATED) }
  scope :temporary, -> { where(version_status: VERSION_STATUS_TEMPORARY) }
  scope :validated_or_temporary, -> { where(version_status: [VERSION_STATUS_TEMPORARY, VERSION_STATUS_VALIDATED]) }

  VERSION_STATUS_TEMPORARY = 'temporary'
  VERSION_STATUS_VALIDATED = 'validated'
  VERSION_STATUS_REJECTED = 'rejected'

  VERSION_STATUSES = [VERSION_STATUS_TEMPORARY, VERSION_STATUS_VALIDATED, VERSION_STATUS_REJECTED].freeze

  VERSION_STATUSES.each do |status|
    define_method "#{status}?" do
      version_status == status
    end
  end

  def loan
    loan_version.loan
  end

  def total_repaid_amount
    principal_repayment_lines.past.paid.sum(&:received_amount)
  end

  def gross_amount
    loan_version.executed_nominal_amount - total_repaid_amount
  end

  def provision_amount
    principal_repayment_lines.pending_status.sum(&:provision)
  end

  def temp_total_repaid_amount
    repayment_calendar_lines.select(&:paid_past_principal).sum(&:received_amount)
  end

  def temp_gross_amount
    loan_version.executed_nominal_amount - temp_total_repaid_amount
  end

  def temp_provision_amount
    repayment_calendar_lines.select(&:pending_principal).sum(&:provision)
  end

  def net_amount
    gross_amount - provision_amount
  end

  def principal_repayments_equal_executed_nominal_amount
    init_values = { original_amount: 0, missed_payments: 0 }
    result = repayment_calendar_lines.select(&:principal?).each_with_object(init_values) do |item, memo|
      next if item.status == RepaymentCalendarLine::STATUS_UNPAID

      memo[:original_amount] += item.original_amount
      item_payment_diff = item.original_amount - item.received_amount

      if item.status == RepaymentCalendarLine::STATUS_PAID && item_payment_diff.positive?
        memo[:missed_payments] += item_payment_diff
      end

      memo
    end

    repayment_calendar_amount = result[:original_amount] - result[:missed_payments]

    if repayment_calendar_amount != loan_version.executed_nominal_amount
      errors.add(:base, I18n.t('repayment_calendars.errors.executed_nominal_amount_different_from_calendar_sum'))
    end
  end

  def principal_lines_attributes
    principal_repayment_lines.map(&:attributes)
  end

  def interest_lines_attributes
    interest_repayment_lines.map(&:attributes)
  end

  def get_last_pending_repayment_calendar_line
    pending_repayment_calendar_line_status = repayment_calendar_lines.pending_status
    pending_repayment_calendar_line_status.order(repayment_date: :asc).last
  end

  def get_sorted_repayment_calendar_lines_by_repayment_date_asc
    repayment_calendar_lines.order(repayment_date: :asc)
  end

  def get_sorted_repayment_calendar_lines_by_repayment_date_asc
    repayment_calendar_lines.order(repayment_date: :asc)
  end
end
