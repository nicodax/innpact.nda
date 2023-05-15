# frozen_string_literal: true

class LoanDecorator < ApplicationDecorator
  decorates Loan

  delegate :formatted_proposed_nominal_amount_usd, :formatted_proposed_nominal_amount,
           :proposed_tenor, :formatted_ratified_nominal_amount_usd, :formatted_ratified_nominal_amount,
           :ratified_tenor, :formatted_approved_nominal_amount_usd, :formatted_approved_nominal_amount,
           :approved_tenor, :formatted_executed_nominal_amount_usd, :formatted_executed_nominal_amount,
           :executed_tenor, :formatted_pending_approval_nominal_amount_usd,
           :formatted_pending_approval_nominal_amount, :pending_approval_tenor, :provision_value,
           :formatted_gross_position_value, :formatted_net_position_value, :provision_value_usd,
           :formatted_gross_position_value_usd, :formatted_net_position_value_usd, :formatted_provision_value,
           :formatted_provision_value_usd, :formatted_nav_usd, :formatted_approved_change_request_nominal_amount_usd,
           :approved_change_request_tenor, :formatted_approved_change_request_nominal_amount,
           :formatted_pending_ratification_nominal_amount_usd, :pending_ratification_tenor,
           :formatted_pending_ratification_nominal_amount, :formatted_proposed_spread, :formatted_ratified_spread,
           :formatted_approved_spread, :formatted_loan_spread, :formatted_hedge_spread, :formatted_pending_ratification_spread,
           :formatted_pending_approval_spread, :formatted_approved_change_request_spread, :formatted_proposed_fixed_rate,
           :formatted_ratified_fixed_rate, :formatted_approved_fixed_rate, :formatted_executed_fixed_rate,
           :formatted_pending_ratification_fixed_rate, :formatted_pending_approval_fixed_rate,
           :formatted_approved_change_request_fixed_rate, :formatted_proposed_upfront_fees, :formatted_ratified_upfront_fees,
           :formatted_approved_upfront_fees, :formatted_executed_upfront_fees, :formatted_pending_ratification_upfront_fees,
           :formatted_pending_approval_upfront_fees, :formatted_approved_change_request_upfront_fees, :invested_hedge_fx_rate,
           :formatted_probabilities, to: :loan_version

  def loan_version
    @loan_version ||=
      LoanVersionDecorator.decorate(loan.active_loan_version ||
                                    loan.build_new_version(status: if new_institution_mode?
                                                                     LoanVersion::STATUS_ASSIGNED
                                                                   else
                                                                     LoanVersion::STATUS_APPETITE_INQUIRY
                                                                   end))
  end

  def repayment_calendar
    object.active_repayment_calendar || active_loan_version&.build_new_repayment_calendar
  end

  def new_institution_mode?
    loan.institution_mode_at_creation == Loan::NEW_INSTITUTION_MODE
  end

  def fund_investment_managers
    fund.users.with_role(User::ROLE_INVESTMENT_MANAGER).assigned_to_institution(institution)
  end

  def created_at
    object.created_at.strftime('%F')
  end

  def status_name
    I18n.t("activerecord.attributes.loan.statuses.#{loan_version.status}")
  end

  def country_name
    institution.try(:country).try(:name)
  end

  def executed_bond_name
    executed_bond.try(:name)
  end

  def approved_bond_name
    approved_bond.try(:name)
  end

  def institution_name
    institution.try(:name)
  end

  def institution_group_name
    institution.try(:institution_group).try(:name)
  end

  def institution_type_name
    institution.institution_type.try(:name)
  end

  def creation_user_name
    creation_user.try(:full_name)
  end

  def group_name
    institution.institution_group.try(:name)
  end

  def country_group_name
    institution.country.country_group.nil? ? '' : institution.country.country_group.name
  end

  def currency_name
    currency.short_name
  end

  def loan_type_name
    loan_type.try(:name)
  end

  def repayment_type_name
    repayment_type.try(:name)
  end

  def loan_interest_rate_type_name
    loan_interest_rate_type.try(:name)
  end

  def approved_interest_rate_type_name
    approved_interest_rate_type.try(:name)
  end

  def hedge_interest_rate_type_name
    hedge_interest_rate_type.try(:name)
  end

  def restructuring_date
    return nil unless repayment_calendar

    repayment_calendar.repayment_calendar_lines.filter_map do |line|
      line.repayment_date if RepaymentCalendarLine.critical_case?(line)
    end.compact.min
  end

  def date_of_entry
    [institution.watchlist_entry_date, provision_date, restructuring_date].compact.min
  end

  def invested_hedge_fx_rate_number(currency_short_name)
    return invested_hedge_fx_rate unless invested_hedge_fx_rate.nil?
    return 1.000000000 if currency_short_name == 'USD'

    nil
  end

  delegate :name, to: :pool, prefix: true

  def lock_basic_params
    persisted?
  end

  def closed?
    LoanVersion::ACCEPTED_STATUSES.include?(status)
  end

  def dashboard_path
    url_helpers = Rails.application.routes.url_helpers
    fund_id = fund.id
    if deleted_at.present?
      url_helpers.fund_deleted_loans_path(fund_id: fund_id)
    elsif loan.matured?
      url_helpers.fund_matured_loan_dashboard_path(fund_id: fund_id)
    elsif LoanVersion::ACCEPTED_STATUSES.include?(status)
      url_helpers.fund_accepted_loan_dashboard_path(fund_id: fund_id)
    elsif loan.in_waiting_list? || LoanVersion::LOAN_REQUEST_STATUSES.include?(status)
      url_helpers.fund_loan_request_dashboard_path(fund_id: fund_id)
    else
      errors.add(:base, I18n.t('loans.errors.path_to_breadcrumbs'))
      throw(:abort)
    end
  end

  def dashboard_path_name
    if deleted_at.present?
      I18n.t('.breadcrumbs.loan_deleted')
    elsif loan.matured?
      I18n.t('.breadcrumbs.loan_matured')
    elsif LoanVersion::ACCEPTED_STATUSES.include?(status)
      I18n.t('.breadcrumbs.loan_accepted')
    elsif loan.in_waiting_list? || LoanVersion::LOAN_REQUEST_STATUSES.include?(status)
      I18n.t('.breadcrumbs.loan_requests')
    else
      errors.add(:base, I18n.t('loans.errors.path_to_breadcrumbs'))
      throw(:abort)
    end
  end

  def edit_loan_path
    Rails.application.routes.url_helpers.edit_fund_loan_path(fund_id: fund.id, id: self)
  end

  def loan_data_specific_statuses
    LoanVersion::DATA_SPECIFIC_STATUSES - [new_institution? ? LoanVersion::STATUS_APPETITE_INQUIRY : LoanVersion::STATUS_ASSIGNED]
  end

  def last_data_specific_status
    loan_versions.select do |lv|
      LoanVersion::DATA_SPECIFIC_STATUSES.include?(lv.status)
    end.max_by(&:version_number).status
  end

  def status_historic
    loan_versions.validated_or_temporary.map(&:status) & loan_data_specific_statuses
  end

  def previous_statuses
    status_historic - [loan_version.status]
  end

  def next_statuses
    loan_version.next_statuses(last_valid_status) - [loan_version.status]
  end

  def statuses_options
    ([loan_version.status] + next_statuses).map do |status|
      [I18n.t("activerecord.attributes.loan.statuses.#{status}"), status]
    end
  end

  def next_data_specific_statuses
    loan_data_specific_statuses & next_statuses
  end

  def status_index
    loan_version.status.present? ? step_statuses.index(loan_version.status) : 0
  end

  def new_institution?
    institution_mode_at_creation == Loan::NEW_INSTITUTION_MODE
  end

  def last_valid_status
    context[:last_valid_status] || loan_version.status
  end

  def accessible_pools
    compliant_pools | (Pool.global_account(fund.id))
  end

  def default_pool
    accessible_pools.first
  end

  def compliant_pools
    @compliant_pools ||= Pool.compliant_with_institution(institution)
  end

  def im_group_name
    im_group&.name
  end

  def original_innpact_loan_id
    original_loan_id.present? ? Loan.with_deleted.find(original_loan_id).innpact_loan_id : ''
  end

  def original_innpact_loan_deleted?
    Loan.only_deleted.find_by(id: original_loan_id).present?
  end

  def compliance_check_statuses
    [LoanVersion::STATUS_RATIFIED, LoanVersion::STATUS_PENDING_APPROVAL,
     LoanVersion::STATUS_APPROVED, LoanVersion::STATUS_APPROVED_CHANGE_REQUEST]
  end

  def compliance_check_available?
    compliance_check_statuses.include?(status)
  end

  def active_sdg_goals
    # loan_sdg_data.current(active_loan_version.presentable_at).first
    loan_sdg_data.latest(id).first
  end

  def sdg_goals_selected
    active_sdg_goals.present? ? active_sdg_goals.attributes.filter { |_name, value| value == true } : []
  end

  def missing_sdg_goals?
    compliance_check_available? && sdg_goals_selected.blank?
  end

  def missing_sdg_goals_or_compliance?
    compliance_check_available? && missing_sdg_goals?
  end

  def presentation_compliance_check
    # presentation_compliance_checks.current(active_loan_version.presentable_at).first
    presentation_compliance_checks.latest(id).first
  end

  def missing_presentation_compliance_checks?
    compliance_check_available? &&
      ((presentation_compliance_check.present? && presentation_compliance_check.incomplete_check?) ||
      presentation_compliance_check.blank?)
  end

  def will_not_be_presented?
    status == LoanVersion::STATUS_RATIFIED && presentable_at.present? &&
      (missing_sdg_goals? || missing_presentation_compliance_checks?)
  end

  def critical_case_types
    types = ''
    types = I18n.t('activerecord.attributes.loan.criticical_cases.watchlist') if loan.in_watchlist?
    types += I18n.t('activerecord.attributes.loan.criticical_cases.restructuring') if loan.restructuring?
    types += I18n.t('activerecord.attributes.loan.criticical_cases.provision') if loan.provision?
    types.chomp(', ')
  end

  def self.not_accepted_loans_columns_titles
    %w[im_group pool unique_id institution group_name country_name country_group_name status local_ccy
       type_of_loan proposed_nominal_amount_usd proposed_nominal_amount_ccy proposed_tenor proposed_spread proposed_upfront
       proposed_fixed_rate bond ratified_nominal_amount_usd ratified_nominal_amount_ccy ratified_tenor ratified_spread
       ratified_upfront ratified_fixed_rate approved_nominal_amount_usd approved_nominal_amount_ccy approved_tenor
       approved_spread approved_upfront approved_fixed_rate assignment_date deadline_assignment_date ratification_date
       deadline_ratification_date approval_date deadline_approval_date expected_disbursement_date interest_rate_type specific_approval_condition
       probabilities institution_type repayment_type original_loan_id].map { |t| I18n.t("activerecord.attributes.loan.#{t}") }
  end

  def self.accepted_loans_columns_titles
    %w[im_group pool noval institution group_name country_name country_group_name status local_ccy
       type_of_loan executed_nominal_amount_usd executed_nominal_amount_ccy executed_tenor loan_spread executed_upfront_fee
       executed_fixed_rate disbursement_date maturity_date bond nav_usd net_position_value gross_position_value
       critical_cases provision_date provision_value interest_rate_type institution_type vrr vrr_maturity_date
       repayment_type original_loan_id].map { |t| I18n.t("activerecord.attributes.loan.#{t}") }
  end

  def not_accepted_loans_columns_values
    [
      im_group_name, pool_name, innpact_loan_id, institution_name, group_name, country_name, country_group_name,
      status, currency_name, loan_type_name, formatted_proposed_nominal_amount_usd, formatted_proposed_nominal_amount,
      proposed_tenor, formatted_proposed_spread, formatted_proposed_upfront_fees, formatted_proposed_fixed_rate, approved_bond_name,
      formatted_ratified_nominal_amount_usd, formatted_ratified_nominal_amount, ratified_tenor, formatted_ratified_spread,
      formatted_ratified_upfront_fees, formatted_ratified_fixed_rate, formatted_approved_nominal_amount_usd,
      formatted_approved_nominal_amount, approved_tenor, formatted_approved_spread, formatted_approved_upfront_fees,
      formatted_approved_fixed_rate, assignment_date, deadline_assignment_date, ratification_date, deadline_ratification_date,
      approval_date, deadline_approval_date, expected_disbursement_date, approved_interest_rate_type_name, specific_approval_condition,
      formatted_probabilities, institution_type_name, repayment_type_name, original_innpact_loan_id
    ]
  end

  def accepted_loans_columns_values
    [
      im_group_name, pool_name, noval, institution_name, group_name, country_name, country_group_name, status,
      currency_name, loan_type_name, formatted_executed_nominal_amount_usd, formatted_executed_nominal_amount, executed_tenor,
      formatted_executed_spread, formatted_executed_upfront_fees, formatted_executed_fixed_rate, disbursement_date, maturity_date,
      executed_bond_name, formatted_nav_usd, formatted_net_position_value, formatted_gross_position_value, critical_cases,
      provision_date, formatted_provision_value, institution_type_name, vrr, vrr_maturity_date,
      repayment_type_name, original_innpact_loan_id, formatted_loan_spread, loan_interest_rate_type_name
    ]
  end

  def form_tab_class(step_status)
    tab_classes = []
    tab_classes += %w[is-active current_status] if step_status == loan_version.status
    tab_classes << 'last_valid_status' if step_status == last_valid_status
    tab_classes.join(' ')
  end

  def repayment_calendar_locked?(current_status)
    current_status && active_loan_version.persisted?
  end

  def formatted_executed_spread
    formatted_hedge_spread || formatted_loan_spread
  end

  def executed_rate_type_name
    hedge_interest_rate_type_name || loan_interest_rate_type_name
  end
end
