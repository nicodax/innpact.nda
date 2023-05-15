# frozen_string_literal: true

class LoansFilter
  include ActiveModel::Validations

  def initialize(loans_scope)
    @loans_scope = loans_scope
    @criteria = []
  end

  def populate_from_params(params)
    params.each do |k, v|
      public_send("append_#{k}_criterion", v)
    end
  end

  def loans
    @loans ||= filter_loans_scope
  end

  def filter_loans_scope
    criteria.inject(loans_scope) do |accumulator, criterion|
      criterion.apply(accumulator)
    end
  end

  %i[im_group_id innpact_loan_id status institution_group_id institution_id
     country_id country_group_id currency_id loan_type_id pool_id specific_approval_condition
     institution_type_id repayment_type_id critical_cases noval
     approved_bond_id approved_interest_rate_type_id executed_bond_id loan_interest_rate_type_id].each do |property|
    define_method "append_#{property}_criterion" do |opts|
      criteria << self.class.const_get("#{property.to_s.camelize}Criterion").new(opts)
    end
  end

  %i[assignment_date deadline_assignment_date ratification_date
     deadline_ratification_date approval_date deadline_approval_date
     approval_date deadline_approval_date expected_disbursement_date
     proposed_nominal_amount_usd proposed_nominal_amount proposed_spread
     proposed_upfront_fees proposed_fixed_rate ratified_nominal_amount_usd ratified_nominal_amount
     ratified_spread ratified_upfront_fees ratified_fixed_rate approved_nominal_amount_usd
     approved_nominal_amount approved_spread approved_upfront_fees
     approved_fixed_rate probabilities
     executed_nominal_amount_usd executed_nominal_amount loan_spread executed_upfront_fees executed_fixed_rate
     disbursement_date maturity_date nav_usd net_position_value gross_position_value
     provision_date provision_value_usd vrr vrr_maturity_date proposed_tenor ratified_tenor
     approved_tenor executed_tenor].each do |property|
    define_method "append_#{property}_begin_criterion" do |opts|
      criteria << self.class.const_get("#{property.to_s.camelize}BeginCriterion").new(opts, '>=')
    end
    define_method "append_#{property}_end_criterion" do |opts|
      criteria << self.class.const_get("#{property.to_s.camelize}EndCriterion").new(opts, '<')
    end
    define_method "append_#{property}_criterion" do |opts|
      send("append_#{property}_begin_criterion", opts['begin']) if opts['begin']
      send("append_#{property}_end_criterion", opts['end']) if opts['end']
    end
  end

  private

  attr_reader :loans_scope, :criteria

  %i[im_group_id innpact_loan_id institution_id noval].each do |property|
    klass_name = "#{property.to_s.camelize}Criterion"
    klass = Class.new(EqualityCriterion) do
      define_method(:selector) do
        "loans.#{property}"
      end
    end
    Object.const_set(klass_name, klass)
  end

  %i[status currency_id loan_type_id pool_id specific_approval_condition repayment_type_id critical_cases
     approved_bond_id approved_interest_rate_type_id executed_bond_id loan_interest_rate_type_id].each do |property|
    klass_name = "#{property.to_s.camelize}Criterion"
    klass = Class.new(EqualityCriterion) do
      def extended_scope(scope)
        scope.joins(:loan_versions).where('loan_versions.version_number = loans.last_loan_version')
      end
      define_method(:selector) do
        "loan_versions.#{property}"
      end
    end
    Object.const_set(klass_name, klass)
  end

  class InstitutionGroupIdCriterion < EqualityCriterion
    def extended_scope(scope)
      scope.joins(:institution)
    end

    def selector
      'institutions.institution_group_id'
    end
  end

  class CountryIdCriterion < EqualityCriterion
    def extended_scope(scope)
      scope.joins(:institution)
    end

    def selector
      'institutions.country_id'
    end
  end

  class InstitutionTypeIdCriterion < EqualityCriterion
    def extended_scope(scope)
      scope.joins(:institution)
    end

    def selector
      'institutions.institution_type_id'
    end
  end

  class CountryGroupIdCriterion < EqualityCriterion
    def extended_scope(scope)
      scope.joins(institution: { country: :country_group })
    end

    def selector
      'country_groups.id'
    end
  end

  %i[assignment_date deadline_assignment_date ratification_date
     deadline_ratification_date approval_date deadline_approval_date expected_disbursement_date
     proposed_nominal_amount_usd proposed_nominal_amount proposed_tenor proposed_spread
     proposed_upfront_fees proposed_fixed_rate ratified_nominal_amount_usd ratified_nominal_amount
     ratified_tenor ratified_spread ratified_upfront_fees ratified_fixed_rate approved_nominal_amount_usd
     approved_nominal_amount approved_tenor approved_spread approved_upfront_fees
     approved_fixed_rate probabilities executed_nominal_amount_usd executed_nominal_amount executed_tenor
     loan_spread executed_upfront_fees executed_fixed_rate
     disbursement_date maturity_date nav_usd net_position_value gross_position_value
     provision_date provision_value_usd vrr vrr_maturity_date repayment_type_id].each do |property|
    begin_klass_name = "#{property.to_s.camelize}BeginCriterion"
    begin_klass = Class.new(InequalityCriterion) do
      def extended_scope(scope)
        scope.joins(:loan_versions).where('loan_versions.version_number = loans.last_loan_version')
      end
      define_method(:selector) do
        "loan_versions.#{property}"
      end
    end
    Object.const_set(begin_klass_name, begin_klass)

    end_klass_name = "#{property.to_s.camelize}EndCriterion"
    end_klass = Class.new(InequalityCriterion) do
      def extended_scope(scope)
        scope.joins(:loan_versions).where('loan_versions.version_number = loans.last_loan_version')
      end
      define_method(:selector) do
        "loan_versions.#{property}"
      end
    end
    Object.const_set(end_klass_name, end_klass)
  end
end
