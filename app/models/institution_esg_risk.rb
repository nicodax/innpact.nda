# frozen_string_literal: true

class InstitutionEsgRisk < ApplicationRecord
  acts_as_paranoid

  belongs_to :institution

  validates :as_of, presence: true

  validates :internal_esg_score, length: { maximum: 10 }

  validate :validate_at_least_one_fields_except_as_of_present

  def self.esms_risk_profile_map
    {
      false => 'No',
      true => 'Yes'
    }
  end

  def self.esms_risk_profile_options
    esms_risk_profile_map.collect { |k, v| [v, k] }
  end

  def validate_at_least_one_fields_except_as_of_present
    return unless %w[
      internal_esg_score ifc_esg_risk_financial_intermediaries_classification
      esms_in_place_commensurate_with_risk_profile tool_use_for_esg_score
    ].all? { |attr| self[attr].blank? }

    errors.add(:base, 'At least one parameter must be present for the model to be saved')
  end
end
