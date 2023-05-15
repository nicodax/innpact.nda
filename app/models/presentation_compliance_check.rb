# frozen_string_literal: true

class PresentationComplianceCheck < ApplicationRecord
  acts_as_paranoid # soft delete

  belongs_to :loan
  scope :current, ->(presentable_at) { where(presentable_at: presentable_at) }
  scope :latest, ->(loan_id) { where(loan_id: loan_id).order(id: :desc) }
  # validates :proposed_investment_complies_with_mef_guidelines,
  #           :investee_microfinance_portfolio_greater_than_two_times_mef_loan,
  #           :kyc_check, :aml_risk_rate, :aml_country_risk_assessment,
  #           :tax_report_assessment, :presentable_at, presence: true

  def incomplete_check?
    [proposed_investment_complies_with_mef_guidelines,
     investee_microfinance_portfolio_greater_than_two_times_mef_loan,
     kyc_check, aml_risk_rate, aml_country_risk_assessment,
     tax_report_assessment].any?(&:blank?)
  end

  def self.kyc_check_values
    %w[reputational_risk_identified no_reputational_risk_identified]
  end

  def self.aml_risk_rate_values
    %w[low medium high red_flag]
  end

  def self.aml_country_risk_assessment_values
    %w[low medium high red_flag]
  end

  def self.tax_report_assessment_values
    %w[
      yes-no_tax_related_reporting_required
      yes-tax_related_reporting_is_required
      no_tax_assessment_not_performed
    ]
  end
end
