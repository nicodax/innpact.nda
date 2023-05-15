# frozen_string_literal: true

class LoanVersion < ApplicationRecord
  acts_as_paranoid # soft delete

  STATUS_ASSIGNED = 'assigned'
  STATUS_APPETITE_INQUIRY = 'appetite_inquiry'
  STATUS_PENDING_RATIFICATION = 'pending_ratification'
  STATUS_RATIFIED = 'ratified'
  STATUS_NOT_RATIFIED = 'not_ratified'
  STATUS_ASSIGNMENT_EXPIRED = 'assignement_expired'
  STATUS_RELEASED_BEFORE_APPROVAL = 'released_before_approval'
  STATUS_PENDING_APPROVAL = 'pending_approval'
  STATUS_APPROVED = 'approved'
  STATUS_NOT_APPROVED = 'not_approved'
  STATUS_APPROVAL_EXPIRED = 'approval_expired'
  STATUS_APPROVED_CHANGE_REQUEST = 'approved_change_request'
  STATUS_INVESTED = 'invested'
  STATUS_RELEASED_AFTER_APPROVAL = 'released_after_approval'
  STATUS_NOT_VALIDATED = 'not_validated'
  STATUS_MATURED = 'matured'
  STATUSES = [STATUS_ASSIGNED, STATUS_APPETITE_INQUIRY, STATUS_PENDING_RATIFICATION, STATUS_RATIFIED,
              STATUS_NOT_RATIFIED, STATUS_ASSIGNMENT_EXPIRED, STATUS_RELEASED_BEFORE_APPROVAL,
              STATUS_PENDING_APPROVAL, STATUS_APPROVED, STATUS_NOT_APPROVED, STATUS_APPROVAL_EXPIRED,
              STATUS_APPROVED_CHANGE_REQUEST, STATUS_INVESTED, STATUS_RELEASED_AFTER_APPROVAL,
              STATUS_MATURED].freeze

  LOAN_REQUEST_STATUSES = [STATUS_ASSIGNED, STATUS_APPETITE_INQUIRY, STATUS_PENDING_RATIFICATION,
                           STATUS_RATIFIED, STATUS_PENDING_APPROVAL, STATUS_APPROVED,
                           STATUS_APPROVED_CHANGE_REQUEST].freeze

  ACCEPTED_STATUSES = [STATUS_NOT_RATIFIED, STATUS_ASSIGNMENT_EXPIRED, STATUS_RELEASED_BEFORE_APPROVAL,
                       STATUS_NOT_APPROVED, STATUS_APPROVAL_EXPIRED, STATUS_INVESTED,
                       STATUS_RELEASED_AFTER_APPROVAL, STATUS_NOT_VALIDATED].freeze

  DATA_SPECIFIC_STATUSES = [STATUS_ASSIGNED, STATUS_APPETITE_INQUIRY, STATUS_PENDING_RATIFICATION,
                            STATUS_RATIFIED, STATUS_PENDING_APPROVAL, STATUS_APPROVED,
                            STATUS_APPROVED_CHANGE_REQUEST, STATUS_INVESTED].freeze

  PIPELINE_STATUSES = [STATUS_ASSIGNED, STATUS_APPETITE_INQUIRY, STATUS_PENDING_RATIFICATION,
                       STATUS_RATIFIED, STATUS_PENDING_APPROVAL, STATUS_APPROVED,
                       STATUS_APPROVED_CHANGE_REQUEST].freeze

  VERSION_STATUS_TEMPORARY = 'temporary'
  VERSION_STATUS_VALIDATED = 'validated'
  VERSION_STATUS_REJECTED = 'rejected'

  VERSION_STATUSES = [VERSION_STATUS_TEMPORARY, VERSION_STATUS_VALIDATED, VERSION_STATUS_REJECTED].freeze

  #TODO This is a temporary solutions that will need to be solved by a refactoring later. These fields are also present in "ACCEPTED_STATUTES".
  REJECTED_STATUSES = [STATUS_APPROVAL_EXPIRED, STATUS_ASSIGNMENT_EXPIRED, STATUS_NOT_APPROVED, STATUS_NOT_RATIFIED,
                       STATUS_NOT_VALIDATED, STATUS_RELEASED_AFTER_APPROVAL, STATUS_RELEASED_BEFORE_APPROVAL].freeze

  belongs_to :loan
  belongs_to :pool
  belongs_to :currency
  belongs_to :repayment_type
  belongs_to :loan_type
  belongs_to :executed_bond, optional: true, class_name: 'Bond'
  belongs_to :approved_bond, optional: true, class_name: 'Bond'
  belongs_to :loan_interest_rate_type, optional: true, class_name: 'InterestRateType'
  belongs_to :approved_interest_rate_type, optional: true, class_name: 'InterestRateType'
  belongs_to :hedge_interest_rate_type, optional: true, class_name: 'InterestRateType'
  belongs_to :creation_user, class_name: 'User'
  belongs_to :validation_user, class_name: 'User', optional: true
  belongs_to :rejection_user, class_name: 'User', optional: true

  has_one :repayment_calendar, dependent: :destroy
  has_one :calendar_log, through: :repayment_calendar

  scope :with_version_number, ->(version_number) { where(version_number: version_number) }
  scope :validated, -> { where(version_status: VERSION_STATUS_VALIDATED) }
  scope :invested, -> { where(status: STATUS_INVESTED) }
  scope :validated_or_temporary, -> { where(version_status: [VERSION_STATUS_TEMPORARY, VERSION_STATUS_VALIDATED]) }

  # float (length max 15)
  validates :proposed_nominal_amount, :proposed_tenor,
            :executed_nominal_amount, :executed_tenor,
            :ratified_nominal_amount, :ratified_tenor,
            :executed_nominal_amount, :executed_tenor,
            :pending_ratification_nominal_amount, :pending_ratification_tenor,
            :pending_approval_nominal_amount, :pending_approval_tenor,
            :approved_change_request_nominal_amount, :approved_change_request_tenor,
            allow_blank: true, numericality: { greater_than_or_equal_to: 0.01, less_than: 1_000_000_000_000_000 }

  # float in Percent
  validates :proposed_spread, :loan_spread,
            :ratified_spread,
            :pending_ratification_spread,
            :pending_approval_spread,
            :approved_change_request_spread,
            allow_blank: true, numericality: { greater_than_or_equal_to: 0.01, less_than: 100 }

  validates :proposed_fixed_rate, :executed_fixed_rate, :ratified_fixed_rate, :pending_ratification_fixed_rate,
            :pending_approval_fixed_rate, :approved_change_request_fixed_rate,
            :proposed_upfront_fees, :executed_upfront_fees, :ratified_upfront_fees,
            :pending_ratification_upfront_fees, :pending_approval_upfront_fees,
            :approved_change_request_upfront_fees,
            allow_blank: true, numericality: { greater_than_or_equal_to: 0, less_than: 100 }

  validates :number_of_disbursement_date_updates, allow_blank: true, numericality: { greater_than: 0 }

  validates_presence_of :validation_user, if: :validated?
  validates_presence_of :rejection_user, if: :rejected?

  # validate :loan_spread_and_interest_type_filled
  validates_presence_of :loan_spread, :loan_interest_rate_type_id, if: :check_executed_status?
  validate :hedge_fields_filled, if: :check_executed_status?

  delegate :total_repaid_amount, :gross_amount, :provision_amount, to: :repayment_calendar, allow_nil: true

  attr_accessor :hedge_checkbox # For validation

  VERSION_STATUSES.each do |status|
    define_method "#{status}?" do
      version_status == status
    end
  end

  def currency_rate
    @currency_rate ||= currency.present? ? (currency.short_name == "USD" ? 1 : currency.current_rate) : 1
  end

  [:proposed_nominal_amount, :ratified_nominal_amount, :approved_nominal_amount,
   :executed_nominal_amount, :pending_ratification_nominal_amount, :pending_approval_nominal_amount,
   :approved_change_request_nominal_amount, :provision_value, :gross_position_value, :net_position_value].each do |attr|
    define_method "#{attr}_usd" do
      send(attr).try(:/, currency_rate)
    end
  end

  def check_executed_status?
    [STATUS_INVESTED, STATUS_MATURED].include?(status)
  end

  def name
    ["INNPACT LOAN #{innpact_loan_id}", institution.try(:name)].compact.join(' - ')
  end

  def next_statuses(for_status)
    LoanVersion.status_state_machine[loan.institution_mode_at_creation][for_status || status]
  end

  def build_new_repayment_calendar(params = {})
    repayment_calendar = build_repayment_calendar(params)
    repayment_calendar.build_calendar_log(creation_user: repayment_calendar.creation_user)
    repayment_calendar
  end

  def self.status_state_machine
    {
      Loan::NEW_INSTITUTION_MODE => {
        STATUS_ASSIGNED => [STATUS_PENDING_RATIFICATION,
                            STATUS_RATIFIED,
                            STATUS_NOT_RATIFIED,
                            STATUS_ASSIGNMENT_EXPIRED,
                            STATUS_RELEASED_BEFORE_APPROVAL],
        STATUS_PENDING_RATIFICATION => [STATUS_RATIFIED,
                                        STATUS_NOT_RATIFIED,
                                        STATUS_ASSIGNMENT_EXPIRED,
                                        STATUS_RELEASED_BEFORE_APPROVAL],
        STATUS_NOT_RATIFIED => [],
        STATUS_ASSIGNMENT_EXPIRED => [],
        STATUS_RELEASED_BEFORE_APPROVAL => [],
      }.merge(common_status_state_machine),
      Loan::INVESTED_INSTITUTION_MODE => {
        STATUS_APPETITE_INQUIRY => [STATUS_PENDING_RATIFICATION,
                                    STATUS_RATIFIED,
                                    STATUS_NOT_VALIDATED],
        STATUS_PENDING_RATIFICATION => [STATUS_RATIFIED,
                                        STATUS_NOT_VALIDATED],
        STATUS_NOT_VALIDATED => [],
      }.merge(common_status_state_machine)
    }
  end

  def self.common_status_state_machine
    {
      STATUS_RATIFIED => [STATUS_PENDING_APPROVAL,
                          STATUS_APPROVED,
                          STATUS_NOT_APPROVED,
                          STATUS_APPROVAL_EXPIRED,
                          STATUS_RELEASED_BEFORE_APPROVAL],
      STATUS_PENDING_APPROVAL => [STATUS_RELEASED_BEFORE_APPROVAL,
                                  STATUS_APPROVED,
                                  STATUS_NOT_APPROVED,
                                  STATUS_APPROVAL_EXPIRED],
      STATUS_APPROVED => [STATUS_APPROVED_CHANGE_REQUEST,
                          STATUS_INVESTED,
                          STATUS_RELEASED_AFTER_APPROVAL],
      STATUS_NOT_APPROVED => [],
      STATUS_APPROVAL_EXPIRED => [],
      STATUS_APPROVED_CHANGE_REQUEST => [STATUS_INVESTED,
                                         STATUS_RELEASED_AFTER_APPROVAL],
      STATUS_INVESTED => [STATUS_MATURED],
      STATUS_MATURED => [STATUS_INVESTED],
      STATUS_RELEASED_AFTER_APPROVAL => [],
    }
  end

  def category
    return "in_waiting_list" if in_waiting_list
    return "accepted" if ACCEPTED_STATUSES.include?(status)

    return "loan_request"
  end

  def fields_labels
    {
      LoanVersion::STATUS_ASSIGNED => "proposed",
      LoanVersion::STATUS_APPETITE_INQUIRY => "proposed",
      LoanVersion::STATUS_PENDING_RATIFICATION => LoanVersion::STATUS_PENDING_RATIFICATION,
      LoanVersion::STATUS_RATIFIED => LoanVersion::STATUS_RATIFIED,
      LoanVersion::STATUS_PENDING_APPROVAL => LoanVersion::STATUS_PENDING_APPROVAL,
      LoanVersion::STATUS_APPROVED => LoanVersion::STATUS_APPROVED,
      LoanVersion::STATUS_APPROVED_CHANGE_REQUEST => LoanVersion::STATUS_APPROVED_CHANGE_REQUEST,
      LoanVersion::STATUS_INVESTED => "executed",
      LoanVersion::STATUS_MATURED => "executed",
      LoanVersion::STATUS_RELEASED_BEFORE_APPROVAL => "executed",
      LoanVersion::STATUS_ASSIGNMENT_EXPIRED => "executed",
      LoanVersion::STATUS_APPROVAL_EXPIRED => "executed",
      LoanVersion::STATUS_NOT_APPROVED => "executed",
      LoanVersion::STATUS_RELEASED_AFTER_APPROVAL => "executed",
      LoanVersion::STATUS_NOT_RATIFIED => "executed",
      LoanVersion::STATUS_NOT_VALIDATED => "executed",
    }
  end

  def date_fields_labels
    {
      LoanVersion::STATUS_ASSIGNED => "assignment",
      LoanVersion::STATUS_APPETITE_INQUIRY => "assignment",
      LoanVersion::STATUS_PENDING_RATIFICATION => "pending_ratification",
      LoanVersion::STATUS_RATIFIED => "ratification",
      LoanVersion::STATUS_PENDING_APPROVAL => "pending_approval",
      LoanVersion::STATUS_APPROVED => "approval",
      LoanVersion::STATUS_APPROVED_CHANGE_REQUEST => "approval_change_request",
    }
  end

  def spread_fields_labels
    {
      LoanVersion::STATUS_ASSIGNED => "proposed",
      LoanVersion::STATUS_APPETITE_INQUIRY => "proposed",
      LoanVersion::STATUS_PENDING_RATIFICATION => LoanVersion::STATUS_PENDING_RATIFICATION,
      LoanVersion::STATUS_RATIFIED => LoanVersion::STATUS_RATIFIED,
      LoanVersion::STATUS_PENDING_APPROVAL => LoanVersion::STATUS_PENDING_APPROVAL,
      LoanVersion::STATUS_APPROVED => LoanVersion::STATUS_APPROVED,
      LoanVersion::STATUS_APPROVED_CHANGE_REQUEST => LoanVersion::STATUS_APPROVED_CHANGE_REQUEST,
      LoanVersion::STATUS_INVESTED => "loan",
      LoanVersion::STATUS_MATURED => "loan",
      LoanVersion::STATUS_RELEASED_BEFORE_APPROVAL => "loan",
      LoanVersion::STATUS_ASSIGNMENT_EXPIRED => "loan",
      LoanVersion::STATUS_APPROVAL_EXPIRED => "loan",
      LoanVersion::STATUS_NOT_APPROVED => "loan",
      LoanVersion::STATUS_RELEASED_AFTER_APPROVAL => "loan",
      LoanVersion::STATUS_NOT_RATIFIED => "loan",
      LoanVersion::STATUS_NOT_VALIDATED => "loan",
    }
  end

  def active_status_nominal_amount
    self.send("#{fields_labels[status]}_nominal_amount")
  end

  def copy
    excluded_attributes = %w[id created_at updated_at]
    new_version = loan.loan_versions.build(attributes.except(*excluded_attributes))
    new_calendar = new_version.build_new_repayment_calendar(repayment_calendar.attributes.except(*excluded_attributes))

    repayment_calendar.repayment_calendar_lines.each do |old_line|
      new_calendar.repayment_calendar_lines.build(old_line.attributes.except(*excluded_attributes))
    end
    new_version
  end

  def has_maturity_date?
    self.maturity_date.present?
  end

  def invested?
    status == STATUS_INVESTED
  end

  def matured?
    status == STATUS_MATURED
  end

  def maturity_date_is_in_past?
    self.has_maturity_date? && maturity_date < Date.today
  end

  def maturity_date_is_in_futur?
    self.has_maturity_date? && maturity_date > Date.today
  end

  def hedge_fields_filled
    return errors.add(:loan, "hedge interest rate type cannot be empty") if hedge_spread.present? && hedge_interest_rate_type_id.nil?
    return errors.add(:loan, "hedge spread cannot be empty") if hedge_spread.nil? && hedge_interest_rate_type_id.present?
  end
end
