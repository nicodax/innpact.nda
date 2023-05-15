# frozen_string_literal: true

class Institution < ApplicationRecord
  TIERS = [['Tier I', 1], ['Tier II', 2], ['Tier III', 3]]
  CPPS = ['Not compliant', 'Compliant - No Certification', 'Compliant', 'Certified']
  REGULATORYSTATUS = ['Regulated', 'Not Regulated']

  # Model used for Institutions.
  # At the start of the project, it was referenced as "mfi", but later on it was decided to change the wording
  acts_as_paranoid
  include HasLimitExceptions
  belongs_to :fund, inverse_of: :institutions
  belongs_to :country
  belongs_to :institution_group
  belongs_to :institution_type
  belongs_to :im_group

  has_many :loans, dependent: :restrict_with_error

  has_one :institution_covenant, dependent: :destroy
  accepts_nested_attributes_for :institution_covenant

  has_many :institution_ratings, dependent: :destroy

  has_many :institution_financials, dependent: :destroy

  has_many :institution_specific_breakdowns, dependent: :destroy

  has_many :institution_impact_indicators, dependent: :destroy

  has_many :positive_impact_services_offereds, dependent: :destroy

  has_many :institution_esg_gender_equalities, dependent: :destroy

  has_many :institution_alinus_results, dependent: :destroy

  has_many :institution_esg_risks, dependent: :destroy

  has_many :institution_esg_safeguards, dependent: :destroy

  has_many :institution_esg_pai_indicators, dependent: :destroy

  has_many :additional_pais_environments, dependent: :destroy

  has_many :additional_pais_socials, dependent: :destroy

  has_many :institution_provisions, dependent: :destroy

  validates :name, presence: true, uniqueness: {
    conditions: lambda {
      with_deleted
    }, scope: :fund_id
  }, length: { maximum: 100 }

  validates :watchlist_reason, length: { maximum: 200 }, presence: true, if: :in_watchlist?

  scope :watchlist, -> { where(in_watchlist: true) }

  scope :provision, lambda {
                      where("exists (select 1 from loans where loans.institution_id = institutions.id AND loans.provision = 'true')")
                    }
  scope :restructuring, lambda {
                          where("exists (select 1 from loans where loans.institution_id = institutions.id AND loans.restructuring = 'true')")
                        }

  # # Decimal (length max 15)
  # validates :gross_loan_portfolio, :portfolio_3y_ago, :microfinance_portfolio_size, :sme_portfolio_size_under_35k, :sme_portfolio_size_under_50k,
  #           allow_blank: true, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 1_000_000_000_000_000 }

  # # Integer (length max 15)
  # validates :borrowers_count, :female_borrowers_count, :rural_borrowers_count, :number_of_micro_borrowers,
  #           :number_of_sme_borrowers, :avg_loan_size,
  #           :number_clients_using_mobile_banking, :number_clients_with_deposits,
  #           allow_blank: true, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 1_000_000_000_000_000 }

  # # Decimal in Percent
  # validates :define_and_monitor_social_goals, :overall_sptf_alinus_score,
  #           :agriculture, :production, :consumption,
  #           :education, :housing, # Could be deleted after refactoring
  #           :ensure_commitment_to_social_goals, :product_design_to_meet_clients_need,
  #           :treat_clients_responsibly, :treat_employees_responsibly, :balance_financial_and_performance, :promote_environmental_protection,
  #           :npls, :trade_and_services, :probability_of_default,
  #           :percentage_rural_ptf, :write_off,
  #           allow_blank: true, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }

  # # Decimal (length max 15) also negative
  # validates :total_assets, :equity, :liabilities, :domestic_liabilities, :international_liabilities,
  #           :other_liabilities, :revenues, :net_income, :provision_for_loss,
  #           :deposit_amount, :saving_amount,
  #           allow_blank: true, numericality: { greater_than_or_equal_to: -1_000_000_000_000_000, less_than_or_equal_to: 1_000_000_000_000_000 }

  # validates :ia_esg_rating, allow_blank: true, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 3 }
  # validates :tier, allow_blank: true, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 3 }
  # validates :external_rating, :external_rating_agency, :internal_credit_risk_rating, length: { maximum: 10 }
  # validates :internal_impact_score, length: { maximum: 10 }
  # validates :list_dfi_lenders, length: { maximum: 1000 }
  # validates :financial_strength_of_shareholders, length: { maximum: 50 }
  validate :empty_watchlist_reason
  validate :set_watchlist_entry_date, if: :in_watchlist_changed?
  # validate :im_group_update, if: :im_group_id_changed?
  # validate :distribution_by_sector_total_sum

  # DECIMAL_VALIDATION_FIELDS = %w[total_assets equity liabilities domestic_liabilities international_liabilities
  #                                other_liabilities revenues net_income net_income_distributed_as_dividends
  #                                provision_for_loss write_off deposit_amount saving_amount
  #                                gross_loan_portfolio portfolio_3y_ago microfinance_portfolio_size sme_portfolio_size_under_35k
  #                                agriculture production education housing consumption other
  #                                overall_sptf_alinus_score define_and_monitor_social_goals
  #                                ensure_commitment_to_social_goals product_design_to_meet_clients_need
  #                                treat_clients_responsibly treat_employees_responsibly balance_financial_and_performance
  #                                microenterprise_usd sme_usd corporate_usd housing_usd personal_usd other_usd
  #                                gross_loan_portfolio portfolio_3y_ago :microfinance_portfolio_size sme_portfolio_size_under_35k percentage_rural_ptf percentage_of_women_ptf
  #                                promote_environmental_protection npls trade_and_services sme_portfolio_size_under_50k].freeze

  PRICE_REGEXP = /^-?\d*\.{0,1}\d{0,2}+$/
  # validate :validate_decimal_fields_two_digit_precision

  def has_accepted_loans?
    loans.accepted.any?
  end

  # TODO This is a temporary solutions that will need to be solved by a refactoring later : ".where.not('loan_versions.status': LoanVersion::REJECTED_STATUSES)"
  def editable_im_group?
    loans.joins(:loan_versions).where("loan_versions.version_number = loans.last_loan_version")
                  .where.not('loan_versions.version_status': LoanVersion::VERSION_STATUS_REJECTED)
                  .where.not('loan_versions.status': LoanVersion::REJECTED_STATUSES)
                  .where.not('loan_versions.status': LoanVersion::STATUS_MATURED).count == 0
  end

  def editable_institution_type?
    institution_type.nil? || loans.joins(:institution).where("institutions.institution_type_id = ?", institution_type.id).count == 0
  end

  def invested?
    loans.invested.any?
  end

  def restructuring?
    loans.where(restructuring: true).any?
  end

  def provision?
    loans.provision.any?
  end

  def current_provision_percentage
    institution_provisions.validated.order(created_at: :desc).first&.new_percentage_of_provision || 0
  end

  def provision_percentage
    return 0 if loans.invested.empty?

    loans.invested.sum(&:provision_value) / loans.invested.sum(&:gross_position_value)
  end

  def loans_provision_summary
    @loans_provision_summary = Institutions::LoansProvisionSummary.new.call(institution: self)
  end

  def active_nominals_summary
    summary = 0
    loans.invested.includes(loan_versions: { currency: :currency_rates }).find_each do |loan|
      summary += loan.active_loan_version.executed_nominal_amount_usd
    end
    summary
  end

  # TODO : TO BE DELETED AFTER REFACTORING
  # def last_institution_esg_sdg_contribution
  #   last_institution_esg_sdg_contribution = institution_esg_sdg_contributions.order(as_of: :asc)
  #   return unless last_institution_esg_sdg_contribution.presence

  #   last_institution_esg_sdg_contribution.where(as_of: last_institution_esg_sdg_contribution.last.as_of).order(updated_at: :asc).last
  # end

  def last_institution_esg_safeguard
    last_institution_esg_safeguard = institution_esg_safeguards.order(as_of: :asc)
    return unless last_institution_esg_safeguard.presence

    last_institution_esg_safeguard.where(as_of: last_institution_esg_safeguard.last.as_of).order(updated_at: :asc).last
  end

  def esg_safeguard_as_of
    last_institution_esg_safeguard.try(:as_of)
  end

  def compliance_with_fund_exclusion_list
    last_institution_esg_safeguard.try(:compliance_with_fund_exclusion_list)
  end

  def compliance_with_international_labour_organization_standards
    last_institution_esg_safeguard.try(:compliance_with_international_labour_organization_standards)
  end

  def compliance_with_international_bill_of_human_rights
    last_institution_esg_safeguard.try(:compliance_with_international_bill_of_human_rights)
  end

  def compliance_with_guiding_principles_on_business_and_human_rights
    last_institution_esg_safeguard.try(:compliance_with_guiding_principles_on_business_and_human_rights)
  end

  def compliance_with_oecd_guidelines_for_multinational_enterprises
    last_institution_esg_safeguard.try(:compliance_with_oecd_guidelines_for_multinational_enterprises)
  end

  def compliance_with_national_standards_and_law
    last_institution_esg_safeguard.try(:compliance_with_national_standards_and_law)
  end

  def compliance_with_client_protection_principles
    last_institution_esg_safeguard.try(:compliance_with_client_protection_principles)
  end

  def last_institution_esg_risk
    last_institution_esg_risk = institution_esg_risks.order(as_of: :asc)
    return unless last_institution_esg_risk.presence

    last_institution_esg_risk.where(as_of: last_institution_esg_risk.last.as_of).order(updated_at: :asc).last
  end

  def internal_esg_score
    last_institution_esg_risk.try(:internal_esg_score)
  end

  def ifc_esg_risk_financial_intermediaries_classification
    last_institution_esg_risk.try(:ifc_esg_risk_financial_intermediaries_classification)
  end

  def esms_in_place_commensurate_with_risk_profile
    last_institution_esg_risk.try(:esms_in_place_commensurate_with_risk_profile)
  end

  def institution_esg_risks_as_of
    last_institution_esg_risk.try(:as_of)
  end

  def tool_use_for_esg_score
    last_institution_esg_risk.try(:tool_use_for_esg_score)
  end

  def last_additional_pais_environment
    last_additional_pais_environment = additional_pais_environments.order(environment_pai_reported: :asc, as_of: :desc, updated_at: :desc)
    unless last_additional_pais_environment.presence
      return [{
        as_of: nil,
        environment_pai_reported: nil,
        environment_pai_value: nil
      }]
    end

    # Unique logic wasn't done is SQL because the query is more complexe than post processing in rails.
    last_additional_pais_environment.uniq { |obj| obj[:environment_pai_reported] }
  end

  def last_additional_pais_social
    last_additional_pais_social = additional_pais_socials.order(social_pai_reported: :asc, as_of: :desc, updated_at: :desc)
    unless last_additional_pais_social.presence
      return [{
        as_of: nil,
        social_pai_reported: nil,
        social_pai_value: nil
      }]
    end

    last_additional_pais_social.uniq { |obj| obj[:social_pai_reported] }
  end

  def last_institution_esg_pai_indicator
    last_institution_esg_pai_indicator = institution_esg_pai_indicators.order(as_of: :asc)
    return unless last_institution_esg_pai_indicator.presence

    last_institution_esg_pai_indicator.where(as_of: last_institution_esg_pai_indicator.last.as_of).order(updated_at: :asc).last
  end

  def institution_esg_pai_indicator_as_of
    last_institution_esg_pai_indicator.try(:as_of)
  end

  def last_institution_rating
    last_institution_rating = institution_ratings.order(as_of: :asc, updated_at: :asc).last
    return unless last_institution_rating.presence

    last_institution_rating
  end

  def general_rating_as_of_date
    last_institution_rating.try(:as_of)
  end

  def internal_credit_risk_rating
    last_institution_rating.try(:internal_credit_risk_rating)
  end

  def external_rating
    last_institution_rating.try(:external_rating)
  end

  def external_rating_agency
    last_institution_rating.try(:external_rating_agency)
  end

  def probability_of_default
    last_institution_rating.try(:probability_of_default)
  end

  def internal_rating
    last_institution_rating.try(:internal_credit_risk_rating)
  end

  def last_institution_financial
    new_record = institution_financials.order(as_of: :desc, updated_at: :desc).first
    return unless new_record.presence

    new_record
  end

  def financials_as_of_date
    last_institution_financial.try(:as_of)
  end

  def gross_loan_portfolio
    last_institution_financial.try(:gross_loan_portfolio)
  end

  def revenues
    last_institution_financial.try(:revenues)
  end

  def provision_for_loss
    last_institution_financial.try(:provision_for_loss)
  end

  def international_liabilities
    last_institution_financial.try(:international_liabilities)
  end

  def domestic_liabilities
    last_institution_financial.try(:domestic_liabilities)
  end

  def net_income
    last_institution_financial.try(:net_income)
  end

  def total_assets
    last_institution_financial.try(:total_assets)
  end

  def net_income_distributed_as_dividends
    last_institution_financial.try(:net_income_distributed_as_dividends)
  end

  def liabilities
    last_institution_financial.try(:liabilities)
  end

  def deposit_amount
    last_institution_financial.try(:deposit_amount)
  end

  def npls
    last_institution_financial.try(:npls)
  end

  def write_off
    last_institution_financial.try(:write_off)
  end

  def equity
    last_institution_financial.try(:equity)
  end

  # def last_institution_distribution_by_sector
  #   #new_record = institution_distribution_by_sectors.order(as_of: :desc, updated_at: :desc).first
  #   institution_specific
  #   return unless new_record.presence

  #   new_record
  # end

  def specific_breakdown_as_of
    last_institution_specific_breakdown.try(:as_of).try(:strftime, '%d-%m-%Y')
  end

  def trade_and_services
    last_institution_specific_breakdown.try(:trade_and_services)
  end

  def agriculture
    last_institution_specific_breakdown.try(:agriculture)
  end

  def production
    last_institution_specific_breakdown.try(:production)
  end

  def consumption
    last_institution_specific_breakdown.try(:consumption)
  end

  def by_sector_other
    last_institution_specific_breakdown.try(:by_sector_other)
  end

  def last_institution_specific_breakdown
    new_record = institution_specific_breakdowns.order(as_of: :desc, updated_at: :desc).first
    return unless new_record.presence

    new_record
  end

  def microfinance_portfolio_size
    last_institution_specific_breakdown.try(:microfinance_portfolio_size)
  end

  def sme_portfolio_size_under_35k
    last_institution_specific_breakdown.try(:sme_portfolio_size_under_35k)
  end

  def sme_portfolio_size_under_50k
    last_institution_specific_breakdown.try(:sme_portfolio_size_under_50k)
  end

  def percentage_rural_ptf
    last_institution_specific_breakdown.try(:percentage_loans_to_rural_borrowers_per_glp)
  end

  # def last_institution_distribution_by_loan_purpose
  #   new_record = institution_distribution_by_loan_purposes.order(as_of: :desc, updated_at: :desc).first
  #   return unless new_record.presence

  #   new_record
  # end

  def microenterprise
    last_institution_specific_breakdown.try(:microenterprise)
  end

  def sme
    last_institution_specific_breakdown.try(:sme)
  end

  def corporate
    last_institution_specific_breakdown.try(:corporate)
  end

  def housing
    last_institution_specific_breakdown.try(:housing)
  end

  def personal
    last_institution_specific_breakdown.try(:personal)
  end

  def by_loan_purpose_other
    last_institution_specific_breakdown.try(:by_loan_purpose_other)
  end

  def last_institution_impact_indicator
    last_institution_impact_indicator = institution_impact_indicators.order(as_of: :asc)
    return unless last_institution_impact_indicator.presence

    last_institution_impact_indicator.where(as_of: last_institution_impact_indicator.last.as_of)
                                     .order(updated_at: :asc).last
  end

  def impact_indicator_as_of_date
    last_institution_impact_indicator.try(:as_of)
  end

  def internal_impact_score
    last_institution_impact_indicator.try(:internal_impact_score)
  end

  def avg_loan_size
    last_institution_impact_indicator.try(:avg_loan_size)
  end

  def number_of_clients
    last_institution_impact_indicator.try(:number_of_clients)
  end

  def borrowers_count
    last_institution_impact_indicator.try(:borrowers_count)
  end

  def rural_borrowers_count
    last_institution_impact_indicator.try(:rural_borrowers_count)
  end

  def female_borrowers_count
    last_institution_impact_indicator.try(:female_borrowers_count)
  end

  def number_of_sme_borrowers
    last_institution_impact_indicator.try(:number_of_sme_borrowers)
  end

  def number_of_micro_borrowers
    last_institution_impact_indicator.try(:number_of_micro_borrowers)
  end

  def last_institution_alinus_result
    last_institution_alinus_result = institution_alinus_results.order(as_of: :asc)
    return unless last_institution_alinus_result.presence

    last_institution_alinus_result.where(as_of: last_institution_alinus_result.last.as_of).order(updated_at: :asc).last
  end

  def institution_alinus_result_as_of
    last_institution_alinus_result.try(:as_of)
  end

  def overall_sptf_alinus_score
    last_institution_alinus_result.try(:overall_sptf_alinus_score)
  end

  def define_and_monitor_social_goals
    last_institution_alinus_result.try(:define_and_monitor_social_goals)
  end

  def social_performance_management
    last_institution_alinus_result.try(:social_performance_management)
  end

  def product_design_to_meet_clients_need
    last_institution_alinus_result.try(:product_design_to_meet_clients_need)
  end

  def treat_clients_responsibly
    last_institution_alinus_result.try(:treat_clients_responsibly)
  end

  def treat_employees_responsibly
    last_institution_alinus_result.try(:treat_employees_responsibly)
  end

  def balance_financial_and_performance
    last_institution_alinus_result.try(:balance_financial_and_performance)
  end

  def promote_environmental_protection
    last_institution_alinus_result.try(:promote_environmental_protection)
  end

  def ensure_commitment_to_social_goals
    last_institution_alinus_result.try(:ensure_commitment_to_social_goals)
  end

  def last_positive_impact_services_offered
    last_positive_impact_services_offered = positive_impact_services_offereds.order(as_of: :asc)
    return unless last_positive_impact_services_offered.presence

    last_positive_impact_services_offered.where(as_of: last_positive_impact_services_offered.last.as_of)
                                         .order(updated_at: :asc).last
  end

  def positive_impact_services_offered_as_of
    last_positive_impact_services_offered.try(:as_of)
  end

  def mobile_banking_services
    last_positive_impact_services_offered.try(:mobile_banking_services)
  end

  def number_clients_using_mobile_banking
    last_positive_impact_services_offered.try(:number_clients_using_mobile_banking)
  end

  def deposits
    last_positive_impact_services_offered.try(:deposits)
  end

  def number_clients_with_deposits
    last_positive_impact_services_offered.try(:number_clients_with_deposits)
  end

  def voluntary_savings
    last_positive_impact_services_offered.try(:voluntary_savings)
  end

  def last_institution_esg_gender_equality
    new_record = institution_esg_gender_equalities.order(as_of: :desc, updated_at: :desc).first
    return unless new_record.presence

    institution_esg_gender_equalities
  end

  def self.is_current_as_of_more_recent?(object_as_of, form_as_of)
    object_as_of && form_as_of.present? && object_as_of > form_as_of
  end

  def self.dropdown_yes_no_map
    {
      true => 'Yes',
      false => 'No'
    }
  end

  def self.dropdown_yes_no_options
    dropdown_yes_no_map.map { |k, v| [v, k] }
  end

  private

  def empty_watchlist_reason
    if !watchlist_reason.blank? && in_watchlist == false
      errors.add(:watchlist_reason, 'The reason must be empty')
    end
  end

  def set_watchlist_entry_date
    self.watchlist_entry_date = Time.now if in_watchlist?
    self.watchlist_entry_date = nil if !in_watchlist?
  end

  def im_group_update
    if persisted? && !editable_im_group?
      errors.add(:im_group_id, 'You are not allow to modify IM Group, since it has not rejected / matured loans')
    end
  end

  # def distribution_by_sector_total_sum
  #   return unless portfolio_values_present?

  #   errors.add(:institution, 'The portfolio breakdown II Total must be equal to 100') if [trade_and_services, agriculture, production, consumption, by_sector_other].compact.sum != 100
  # end

  # def portfolio_values_present?
  #   [trade_and_services, agriculture, production, consumption, by_loan_purpose_other].any?
  # end
end
