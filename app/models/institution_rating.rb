# frozen_string_literal: true

class InstitutionRating < ApplicationRecord
  acts_as_paranoid

  belongs_to :institution

  validates :as_of, presence: true

  validates :external_rating, :external_rating_agency, :internal_credit_risk_rating, length: { maximum: 10 }

  # Decimal in Percent
  validates :probability_of_default, allow_blank: true, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }

  validate :validate_at_least_one_fields_except_as_of_present

  def self.rating_agencies_map
    {
      'moody_s' => 'Moody\'s',
      'standard_and_poor_s' => 'Standard & Poor\'s',
      'fitch' => 'Fitch'
    }
  end

  def self.rating_agencies_options
    rating_agencies_map.collect { |k, v| [v, k] }
  end

  def validate_at_least_one_fields_except_as_of_present
    return unless %w[external_rating external_rating_agency internal_credit_risk_rating probability_of_default].all? { |attr| self[attr].blank? }

    errors.add(:base, 'At least one parameter must be present for the model to be saved')
  end
end
