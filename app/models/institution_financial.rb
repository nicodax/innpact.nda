# frozen_string_literal: true

class InstitutionFinancial < ApplicationRecord
  acts_as_paranoid

  belongs_to :institution

  validates :as_of, presence: true

  # Decimal can be negative
  validates :liabilities, :domestic_liabilities, :international_liabilities, :revenues,
            :net_income_distributed_as_dividends, :provision_for_loss, :write_off, :deposit_amount,
            :total_assets, :gross_loan_portfolio, :equity, :net_income, :npls,
            allow_blank: true, numericality: { greater_than_or_equal_to: -1_000_000_000_000_000, less_than_or_equal_to: 1_000_000_000_000_000 }

  DECIMAL_VALIDATION_FIELDS = %w[liabilities domestic_liabilities international_liabilities revenues
                                 net_income_distributed_as_dividends provision_for_loss write_off deposit_amount
                                 total_assets gross_loan_portfolio equity net_income npls].freeze

  PRICE_REGEXP = /^-?\d*\.{0,1}\d{0,2}+$/
  validate :validate_decimal_fields_two_digit_precision

  validate :validate_at_least_one_fields_except_as_of_present

  def validate_decimal_fields_two_digit_precision
    DECIMAL_VALIDATION_FIELDS.each do |field|
      next unless read_attribute_before_type_cast(field).blank? == false &&
                  PRICE_REGEXP.match(read_attribute_before_type_cast(field).to_s) == false

      errors.add(field, 'The input is invalid. There can only be two digits at most after the decimal point.')
    end
  end

  def validate_at_least_one_fields_except_as_of_present
    return unless %w[
      liabilities domestic_liabilities international_liabilities revenues net_income_distributed_as_dividends provision_for_loss
      write_off deposit_amount total_assets gross_loan_portfolio equity net_income npls
    ].all? { |attr| self[attr].blank? }

    errors.add(:base, 'At least one parameter must be present for the model to be saved')
  end
end
