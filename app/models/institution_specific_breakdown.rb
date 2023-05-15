# frozen_string_literal: true

class InstitutionSpecificBreakdown < ApplicationRecord
  acts_as_paranoid

  belongs_to :institution

  validates :as_of, presence: true

  validate :by_sector_total_percentage_validation
  validate :by_loan_purpose_total_percentage_validation

  # Decimal (length max 15)
  validates :microfinance_portfolio_size, :sme_portfolio_size_under_35k, :sme_portfolio_size_under_50k,
            allow_blank: true, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 1_000_000_000_000_000 }

  # Decimal in Percent
  validates :percentage_loans_to_rural_borrowers_per_glp,
            :trade_and_services, :agriculture, :production, :consumption, :by_sector_other,
            :microenterprise, :sme, :corporate, :housing, :personal, :by_loan_purpose_other,
            allow_blank: true, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }

  validate :validate_at_least_one_fields_except_as_of_present

  DECIMAL_VALIDATION_FIELDS = %w[ percentage_loans_to_rural_borrowers_per_glp
                                  trade_and_services agriculture production consumption by_sector_other
                                  microenterprise sme corporate housing personal by_loan_purpose_other
                                  microfinance_portfolio_size sme_portfolio_size_under_35k sme_portfolio_size_under_50k].freeze

  PRICE_REGEXP = /^-?\d*\.{0,1}\d{0,2}+$/
  validate :validate_decimal_fields_two_digit_precision

  def validate_decimal_fields_two_digit_precision
    DECIMAL_VALIDATION_FIELDS.each do |field|
      next unless read_attribute_before_type_cast(field).blank? == false &&
                  PRICE_REGEXP.match(read_attribute_before_type_cast(field).to_s) == false

      errors.add(field, 'The input is invalid. There can only be two digits at most after the decimal point.')
    end
  end

  def by_sector_total
    [trade_and_services, agriculture, production, consumption, by_sector_other].compact.sum
  end

  def by_loan_purpose_total
    [microenterprise, sme, corporate, housing, personal, by_loan_purpose_other].compact.sum
  end

  def by_sector_total_percentage_validation
    errors.add(:institution, 'The breakdown by sector total must be equal to 100') if by_sector_total != 100 && by_sector_total != 0
  end

  def by_loan_purpose_total_percentage_validation
    errors.add(:institution, 'The breakdown by loan purpose total must be equal to 100') if by_loan_purpose_total != 100 && by_loan_purpose_total != 0
  end

  def validate_at_least_one_fields_except_as_of_present
    return unless %w[
      microfinance_portfolio_size sme_portfolio_size_under_35k sme_portfolio_size_under_50k percentage_loans_to_rural_borrowers_per_glp
      production agriculture consumption by_sector_other trade_and_services microenterprise sme corporate housing personal by_loan_purpose_other
    ].all? { |attr| self[attr].blank? }

    errors.add(:base, 'At least one parameter must be present for the model to be saved')
  end
end
