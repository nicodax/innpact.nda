# frozen_string_literal: true

class RepaymentCalendarLine < ApplicationRecord
  acts_as_paranoid

  REPAYMENT_TYPE_PRINCIPAL = 'principal'
  REPAYMENT_TYPE_INTEREST = 'interest'
  REPAYMENT_TYPES = [REPAYMENT_TYPE_PRINCIPAL, REPAYMENT_TYPE_INTEREST].freeze

  STATUS_UNPAID = 'unpaid'
  STATUS_PAID = 'paid'
  STATUS_PENDING = 'pending'
  STATUSES = [STATUS_UNPAID, STATUS_PAID, STATUS_PENDING].freeze

  belongs_to :repayment_calendar
  belongs_to :previous_version_line, class_name: 'RepaymentCalendarLine', optional: true
  has_one :repayment_calendar_line, class_name: 'RepaymentCalendarLine', inverse_of: :previous_version_line,
                                    foreign_key: :previous_version_line_id, dependent: :destroy

  has_many :new_reference_calendar_log_lines, class_name: 'CalendarLogLine', inverse_of: :new_repayment_line,
                                              foreign_key: :new_repayment_line_id, dependent: :destroy
  has_many :original_reference_calendar_log_lines, class_name: 'CalendarLogLine',
                                                   inverse_of: :original_repayment_line,
                                                   foreign_key: :original_repayment_line_id, dependent: :destroy

  validates_presence_of :repayment_date, :repayment_type, :original_amount, :received_amount, :status, :provision
  validates :provision, :original_amount, :received_amount, numericality: { greater_than_or_equal_to: 0 }
  validate :paid_policy, if: proc { |repayment_calendar_line| repayment_calendar_line.status == STATUS_PAID }
  validate :original_amount_policy, if: proc { |repayment_calendar_line| repayment_calendar_line.original_amount <= 0 &&  repayment_calendar_line.status == STATUS_PENDING}

  scope :principal, -> { where(repayment_type: REPAYMENT_TYPE_PRINCIPAL) }
  scope :interest, -> { where(repayment_type: REPAYMENT_TYPE_INTEREST) }

  scope :pending_status, -> { where(status: STATUS_PENDING) }
  scope :paid, -> { where(status: STATUS_PAID) }

  scope :past, -> { where('repayment_date <= ?', Date.today) }

  scope :for_loan_ids, ->(loan_ids) {
                         joins(repayment_calendar: [loan_version: :loan])
                           .where('loan_versions.version_number = loans.last_loan_version')
                           .where("loans.id": loan_ids)
                       }
  scope :for_loan, ->(loan) {
                     joins(repayment_calendar: [:loan_version])
                       .where('loan_versions.loan_id = ? AND loan_versions.version_number = ?',
                              loan.id, loan.last_loan_version)
                   }
  scope :for_loans, ->(loan_ids) {
                      joins(repayment_calendar: [loan_version: :loan])
                        .where('loan_versions.version_number = loans.last_loan_version')
                        .where('loan_versions.loan_id': loan_ids)
                    }
  scope :for_fund, ->(fund) {
                     joins(repayment_calendar: [:loan])
                       .where('repayment_calendars.loan_id = loans.id AND repayment_calendars.version_number = loans.last_repayment_calendar_version')
                       .where('loans.fund_id = ?', fund.id)
                   }
  scope :for_institution, ->(institution) {
                            joins(repayment_calendar: [:loan])
                              .where('repayment_calendars.loan_id = loans.id AND repayment_calendars.version_number = loans.last_repayment_calendar_version')
                              .where('loans.institution_id = ?', institution.id)
                          }

  def self.critical_case?(line)
    previous_line = line.previous_version_line

    line.principal? &&
      (line.previous_version_line.blank? ||
      line.original_amount != previous_line&.original_amount ||
      line.status != previous_line&.status && line.status != STATUS_PAID ||
      line.repayment_date != previous_line&.repayment_date)
  end

  def pending_principal
    repayment_type == REPAYMENT_TYPE_PRINCIPAL && status == STATUS_PENDING
  end

  def paid_past_principal
    repayment_type == REPAYMENT_TYPE_PRINCIPAL && status == STATUS_PAID && repayment_date <= Date.today
  end

  def principal?
    repayment_type == REPAYMENT_TYPE_PRINCIPAL
  end

  def paid_policy
    if repayment_date > Date.today
      errors.add(:status, I18n.t('activerecord.errors.repayment_calendar_line.status.future_payment'))
    end
  end

  def original_amount_policy
    if repayment_date > Date.today
      errors.add(:original_amount, I18n.t('activerecord.errors.repayment_calendar_line.status.original_amount'))
    end
  end
end
