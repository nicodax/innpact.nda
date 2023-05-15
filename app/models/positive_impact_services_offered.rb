# frozen_string_literal: true

class PositiveImpactServicesOffered < ApplicationRecord
  acts_as_paranoid

  belongs_to :institution

  validates :as_of, presence: true

  # Integer (length max 15)
  validates :number_clients_using_mobile_banking, :number_clients_with_deposits,
            allow_blank: true, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 1_000_000_000_000_000 }

  validate :validate_at_least_one_fields_except_as_of_present

  def self.optional_boolean_map
    {
      nil => 'Not Provided',
      true => 'Yes',
      false => 'No'
    }
  end

  def self.services_offered_boolean_map
    optional_boolean_map
  end

  def self.deposits_boolean_map
    optional_boolean_map
  end

  def self.voluntary_savings_boolean_map
    optional_boolean_map
  end

  def self.services_offered_boolean_options
    services_offered_boolean_map.collect { |k, v| [v, k] }
  end

  def self.deposits_boolean_options
    deposits_boolean_map.collect { |k, v| [v, k] }
  end

  def self.voluntary_savings_boolean_options
    voluntary_savings_boolean_map.collect { |k, v| [v, k] }
  end

  def validate_at_least_one_fields_except_as_of_present
    return unless %w[
      mobile_banking_services number_clients_using_mobile_banking deposits
      number_clients_with_deposits voluntary_savings
    ].all? { |attr| self[attr].blank? }

    errors.add(:base, 'At least one parameter must be present for the model to be saved')
  end
end
