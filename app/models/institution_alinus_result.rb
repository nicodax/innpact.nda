# frozen_string_literal: true

class InstitutionAlinusResult < ApplicationRecord
  acts_as_paranoid

  belongs_to :institution

  validates :as_of, presence: true

  validates :overall_sptf_alinus_score, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }, allow_nil: true
  validates :define_and_monitor_social_goals, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }, allow_nil: true
  validates :ensure_commitment_to_social_goals, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }, allow_nil: true
  validates :product_design_to_meet_clients_need, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }, allow_nil: true
  validates :treat_clients_responsibly, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }, allow_nil: true
  validates :treat_employees_responsibly, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }, allow_nil: true
  validates :balance_financial_and_performance, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }, allow_nil: true
  validates :promote_environmental_protection, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }, allow_nil: true

  validate :validate_at_least_one_fields_except_as_of_present
  DECIMAL_VALIDATION_FIELDS = %w[overall_sptf_alinus_score define_and_monitor_social_goals ensure_commitment_to_social_goals
                                 product_design_to_meet_clients_need treat_clients_responsibly treat_employees_responsibly
                                 balance_financial_and_performance promote_environmental_protection].freeze

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
    return unless %w[
      has_sptf_alinus_reporting_using_alinus sptf_alinus_reporting_using_alinus overall_sptf_alinus_score define_and_monitor_social_goals
      ensure_commitment_to_social_goals product_design_to_meet_clients_need treat_clients_responsibly treat_employees_responsibly
      balance_financial_and_performance promote_environmental_protection
    ].all? { |attr| self[attr].blank? }

    errors.add(:base, 'At least one parameter must be present for the model to be saved')
  end
end
