# frozen_string_literal: true

class Loan < ApplicationRecord
  acts_as_paranoid # soft delete

  NEW_INSTITUTION_MODE = 'new'
  INVESTED_INSTITUTION_MODE = 'invested'

  belongs_to :fund
  belongs_to :im_group
  belongs_to :institution, optional: true
  belongs_to :creation_user, class_name: 'User'

  scope :loan_request, -> {
                         joins(:loan_versions).where('version_number = last_loan_version')
                                              .where('loan_versions.in_waiting_list' => false)
                                              .where('loan_versions.status' => [LoanVersion::LOAN_REQUEST_STATUSES])
                       }
  scope :waiting_list, -> {
                         joins(:loan_versions).where('version_number = last_loan_version')
                                              .where('loan_versions.in_waiting_list' => true)
                                              .where('loan_versions.status' => LoanVersion::STATUS_ASSIGNED)
                       }
  scope :accepted, -> {
                     joins(:loan_versions).where('version_number = last_loan_version')
                                          .where('loan_versions.status' => [LoanVersion::ACCEPTED_STATUSES])
                   }
  scope :invested, -> {
                     joins(:loan_versions).where('version_number = last_loan_version')
                                          .where('loan_versions.status' => [LoanVersion::STATUS_INVESTED])
                   }

  scope :matured, -> {
    joins(:loan_versions).where('version_number = last_loan_version')
                         .where('loan_versions.status' => LoanVersion::STATUS_MATURED)
  }

  scope :pipeline_loans, -> {
    joins(:loan_versions).where('version_number = last_loan_version')
                         .where('loan_versions.in_waiting_list' => false)
                         .where('loan_versions.status' => [LoanVersion::PIPELINE_STATUSES])
  }

  scope :for_fund, ->(fund) { where(fund_id: fund.id) }
  scope :for_institution, ->(institution) { where(institution_id: institution.id) }

  has_many :loan_sdg_data, class_name: 'LoanSdgData', dependent: :destroy
  has_many :presentation_compliance_checks, dependent: :destroy
  # ->(record) { where(presentable_at: record.active_loan_version.presentable_at) },
  # ->(record) { where(loan_id: record.id).order(updated_at: :desc) },

  # validates_associated :loan_sdg_data,
  #                     if: proc { |record| record.presentable_at.present? }
  # validates_associated :presentation_compliance_check,
  #                     if: proc { |record| record.presentable_at.present? }

  has_many :loan_versions, dependent: :destroy
  has_many :repayment_calendars, through: :loan_versions
  has_many :calendar_logs, through: :repayment_calendars
  has_many :loan_provisions, dependent: :destroy

  scope :watchlist, -> { joins(:institution).merge(Institution.watchlist) }
  scope :provision, -> {
                      joins(:loan_versions).where('version_number = last_loan_version')
                                           .where('loan_versions.provision_value > 0')
                    }
  scope :restructuring, -> { where(restructuring: true) }

  scope :maturity_date_was_yesterday, -> { joins(:loan_versions).where('version_number = last_loan_version')
                                                                .where('loan_versions.status' => [LoanVersion::STATUS_INVESTED])
                                                                .where('loan_versions.maturity_date = ?', Date.today - 1.day) 
                                          }
  delegate :status,
           :proposed_nominal_amount_usd, :proposed_nominal_amount, :proposed_tenor,
           :proposed_spread, :proposed_upfront_fees, :proposed_fixed_rate, :assignment_date,
           :deadline_assignment_date, :approval_date, :deadline_approval_date,
           :expected_disbursement_date, :probabilities, :currency, :loan_type, :currency_id, :loan_type_id,
           :repayment_type_id, :repayment_type, :pending_ratification_nominal_amount_usd,
           :pending_ratification_nominal_amount, :pending_ratification_tenor,
           :pending_ratification_spread, :pending_ratification_upfront_fees,
           :pending_ratification_fixed_rate, :pending_ratification_date,
           :deadline_pending_ratification_date, :ratified_nominal_amount_usd,
           :ratified_nominal_amount, :ratified_tenor,
           :ratified_spread, :ratified_upfront_fees, :ratified_fixed_rate,
           :ratification_date, :deadline_ratification_date, :pending_approval_nominal_amount_usd,
           :pending_approval_nominal_amount, :pending_approval_tenor,
           :pending_approval_spread, :pending_approval_upfront_fees, :pending_approval_fixed_rate,
           :pending_approval_date, :deadline_pending_approval_date, :approved_nominal_amount_usd,
           :approved_nominal_amount, :approved_tenor, :approved_spread,
           :approved_upfront_fees, :approved_fixed_rate, :approved_change_request_nominal_amount_usd,
           :approved_change_request_nominal_amount, :approved_change_request_tenor,
           :approved_change_request_spread, :approved_change_request_upfront_fees,
           :approved_change_request_fixed_rate, :approval_change_request_date,
           :deadline_approval_change_request_date, :executed_nominal_amount_usd,
           :executed_nominal_amount, :executed_tenor, :loan_spread,
           :executed_upfront_fees, :executed_fixed_rate, :disbursement_date, :maturity_date,:nav_usd,
           :executed_bond, :approved_bond, :number_of_disbursement_date_updates,
           :loan_interest_rate_type_id, :loan_interest_rate_type, :approved_interest_rate_type_id, :approved_interest_rate_type,
           :net_position_value, :gross_position_value, :specific_approval_condition, :critical_cases, :version_status,
           :category, :provision_value, :vrr, :vrr_maturity_date, :pool, :pool_id,
           :pending_ratification_comment,:ratified_comment,:not_ratified_comment,:assignement_expired_comment,:released_before_approval_comment,
           :pending_approval_comment,:approved_comment,:not_approved_comment,:approval_expired_comment,:approved_change_request_comment,
           :invested_comment,:released_after_approval_comment,:not_validated_comment,
           :invested_hedge_fx_rate, :hedge_spread, :hedge_interest_rate_type_id, :hedge_interest_rate_type,
           :total_repaid_amount, :provision_amount, :gross_amount, :hedge_comment, to: :active_loan_version

  delegate :provision_date, :presentable_at, to: :active_loan_version, allow_nil: true

  def self.current_statuses_editable_by_ims
    [
      LoanVersion::STATUS_APPETITE_INQUIRY,
      LoanVersion::STATUS_APPROVED,
      LoanVersion::STATUS_APPROVED_CHANGE_REQUEST,
      LoanVersion::STATUS_ASSIGNED,
      LoanVersion::STATUS_PENDING_APPROVAL,
      LoanVersion::STATUS_PENDING_RATIFICATION,
      LoanVersion::STATUS_RATIFIED
    ]
  end

  def name
    ["INNPACT LOAN #{innpact_loan_id}", institution.try(:name)].compact.join(' - ')
  end

  def active_loan_version
    loan_versions.detect do |version|
      version.version_number == last_loan_version && version.version_status != LoanVersion::VERSION_STATUS_REJECTED
    end
  end

  def active_repayment_calendar
    active_loan_version&.repayment_calendar
  end

  def first_repayment_calendar
    repayment_calendars.validated_or_temporary.order(:created_at).first
  end

  def matured?
    active_loan_version.status == LoanVersion::STATUS_MATURED
  end

  def in_watchlist?
    return institution.in_watchlist?
  end

  def in_waiting_list?
    return active_loan_version.in_waiting_list
  end

  def provision?
    (provision_value || 0) > 0
  end

  def build_new_version_with_calendar(version_params = {}, calendar_params)
    new_version_number = last_loan_version + 1
    old_version = active_loan_version
    if old_version.present?
      new_version = loan_versions.build(old_version.attributes.except(*new_version_params_to_ignore)
                                          .merge({ version_number: new_version_number }).merge(version_params))
      calendar_to_copy = old_version.repayment_calendar
      if calendar_to_copy.present?
        new_version.build_repayment_calendar(calendar_to_copy.attributes.except(*new_version_params_to_ignore)
                                               .merge(calendar_params)
                                               .merge(repayment_calendar_lines: calendar_to_copy.repayment_calendar_lines.map { |line|
                                                                                  RepaymentCalendarLine.new(line.attributes.except(*new_repayment_calendar_line_params_to_ignore).merge({ previous_version_line_id: line.id }))
                                                                                }))
      end
    else
      new_version = loan_versions.build({ version_number: new_version_number }.merge(params))
    end
    self.last_loan_version = new_version_number
    new_version
  end

  def build_new_version(params = {})
    new_version_number = last_loan_version + 1
    if active_loan_version.present?
      new_version = loan_versions.build(active_loan_version.attributes.except(*new_version_params_to_ignore)
                                          .merge({ version_number: new_version_number }).merge(params))
    else
      new_version = loan_versions.build({ version_number: new_version_number }.merge(params))
    end
    self.last_loan_version = new_version_number
    new_version
  end

  def build_new_version_from_last_validated(version_params = {}, calendar_params)
    new_version_number = last_loan_version + 1
    version_to_copy = loan_versions.validated.sort_by(&:version_number).last
    new_version = loan_versions.build(version_to_copy.attributes.except(*new_version_params_to_ignore)
                                        .merge(version_status: LoanVersion::VERSION_STATUS_VALIDATED)
                                        .merge({ version_number: new_version_number }).merge(version_params))
    self.last_loan_version = new_version_number

    if version_to_copy.repayment_calendar.present?
      calendar_to_copy = version_to_copy.repayment_calendar
      new_version.build_repayment_calendar(calendar_to_copy.attributes.except(*new_version_params_to_ignore)
                                             .merge(version_status: RepaymentCalendar::VERSION_STATUS_VALIDATED)
                                             .merge(calendar_params)
                                             .merge(repayment_calendar_lines: calendar_to_copy.repayment_calendar_lines
                                                                     .map { |line| RepaymentCalendarLine.new(line.attributes.except(*new_repayment_calendar_line_params_to_ignore)) }))
    end

    new_version
  end

  #
  # def build_new_repayment_calendar_from_last_version(params = {})
  #   new_version_number = last_repayment_calendar_version + 1
  #   version_to_copy = repayment_calendars.sort_by(&:version_number).last
  #   new_version = repayment_calendars.build(version_to_copy.attributes.except(*new_version_params_to_ignore)
  #                                             .merge({version_number: new_version_number})
  #                                             .merge(params).merge(repayment_calendar_lines: version_to_copy.repayment_calendar_lines.map{| line | RepaymentCalendarLine.new(line.attributes.except(*new_repayment_calendar_line_params_to_ignore).merge({previous_version_line_id: line.id}))}))
  #   self.last_repayment_calendar_version = new_version_number
  #   new_version
  # end
  #
  # def build_new_repayment_calendar_from_last_validated(params = {})
  #   new_version_number = last_repayment_calendar_version + 1
  #   version_to_copy = repayment_calendars.validated.sort_by(&:version_number).last
  #   new_version = repayment_calendars.build(version_to_copy.attributes.except(*new_version_params_to_ignore)
  #                                             .merge({version_number: new_version_number})
  #                                             .merge(params).merge(repayment_calendar_lines: version_to_copy.repayment_calendar_lines.map{| line | RepaymentCalendarLine.new(line.attributes.except(*new_repayment_calendar_line_params_to_ignore))}))
  #   self.last_repayment_calendar_version = new_version_number
  #   new_version
  # end

  def new_version_params_to_ignore
    ["id", "created_at", "updated_at", "creation_user", "version_status", "validation_user_id", "rejection_user_id"]
  end

  def new_repayment_calendar_line_params_to_ignore
    ["id", "created_at", "updated_at", "repayment_calendar_id"]
  end

  def copy
    excluded_attributes = %w[id created_at updated_at innpact_loan_id last_loan_version repayment_calendar_id]
    new_version = Loan.new(attributes.except(*excluded_attributes))
    loan_versions.each do |loan_version|
      new_loan_version = new_version.build_new_version(loan_version.attributes.except(*excluded_attributes))
      if loan_version.status == LoanVersion::STATUS_INVESTED
        new_calendar = new_loan_version.build_new_repayment_calendar(loan_version.repayment_calendar.attributes.except(*excluded_attributes))

        loan_version.repayment_calendar.repayment_calendar_lines.each do |old_line|
          new_calendar.repayment_calendar_lines.build(old_line.attributes.except(*excluded_attributes))
        end
      end
    end
    new_version
  end

  def has_tranches?
    nb_tranches > 0
  end

  def nb_tranches
    Loan.where(original_loan_id: original_loan_id.nil? ? id : original_loan_id).size
  end

  def parent_loan?
    has_tranches? && original_loan_id.nil?
  end

  def is_children?
    original_loan_id.present?
  end

  def index_of_tranches
    Loan.where(original_loan_id: original_loan_id).index(self)
  end
end
