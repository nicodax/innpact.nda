# frozen_string_literal: true

class InstitutionEsgGenderEquality < ApplicationRecord
  acts_as_paranoid

  belongs_to :institution

  validates :as_of, presence: true

  validate :validate_at_least_one_fields_except_as_of_present

  # Decimal in Percent
  validates :women_percentage_in_board, :women_percentage_in_staff, :percentage_women_among_loan_officers,
            :women_percentage_in_management, :percentage_loans_to_women_borrowers_per_glp,
            allow_blank: true, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }

  DECIMAL_VALIDATION_FIELDS = %w[women_percentage_in_board women_percentage_in_staff percentage_women_among_loan_officers
                                 women_percentage_in_management percentage_loans_to_women_borrowers_per_glp].freeze

  PRICE_REGEXP = /^-?\d*\.{0,1}\d{0,2}+$/
  validate :validate_decimal_fields_two_digit_precision

  def validate_decimal_fields_two_digit_precision
    DECIMAL_VALIDATION_FIELDS.each do |field|
      next unless read_attribute_before_type_cast(field).blank? == false &&
                  PRICE_REGEXP.match(read_attribute_before_type_cast(field).to_s) == false

      errors.add(field, 'The input is invalid. There can only be two digits at most after the decimal point.')
    end
  end

  def validate_at_least_one_fields_except_as_of_present
    return unless %w[women_percentage_in_board women_percentage_in_staff financial_services_targeting_women
                     non_financial_services_targeting_women training_on_responsible_finance_targeting_women
                     women_percentage_in_management percentage_loans_to_women_borrowers_per_glp
                     percentage_women_among_loan_officers].all? { |attr| self[attr].blank? }

    errors.add(:base, 'At least one parameter must be present for the model to be saved')
  end
end
