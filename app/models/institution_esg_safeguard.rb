# frozen_string_literal: true

class InstitutionEsgSafeguard < ApplicationRecord
  acts_as_paranoid

  belongs_to :institution

  validates :as_of, presence: true

  validate :validate_at_least_one_fields_except_as_of_present

  def self.safeguard_boolean_map
    {
      true => 'Yes',
      false => 'No'
    }
  end

  def self.safeguard_boolean_options
    safeguard_boolean_map.collect { |k, v| [v, k] }
  end

  def self.safeguard_boolean_with_na_map
    {
      'Yes' => 'Yes',
      'No' => 'No',
      'Not Applicable' => 'Not Applicable'
    }
  end

  def self.safeguard_boolean_with_na_options
    safeguard_boolean_with_na_map.collect { |k, v| [v, k] }
  end

  def validate_at_least_one_fields_except_as_of_present
    return unless %w[
      compliance_with_fund_exclusion_list compliance_with_international_labour_organization_standards
      compliance_with_international_bill_of_human_rights
      compliance_with_guiding_principles_on_business_and_human_rights
      compliance_with_oecd_guidelines_for_multinational_enterprises
      compliance_with_national_standards_and_law compliance_with_client_protection_principles
    ].all? { |attr| self[attr].blank? }

    errors.add(:base, 'At least one parameter must be present for the model to be saved')
  end
end
