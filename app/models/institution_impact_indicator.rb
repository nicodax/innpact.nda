# frozen_string_literal: true

class InstitutionImpactIndicator < ApplicationRecord
  acts_as_paranoid

  belongs_to :institution

  validates :as_of, presence: true

  validates :internal_impact_score, length: { maximum: 10 }

  validate :validate_at_least_one_fields_except_as_of_present

  # Integer (length max 15)
  validates :avg_loan_size, :borrowers_count, :female_borrowers_count, :rural_borrowers_count,
            :number_of_micro_borrowers, :number_of_sme_borrowers,
            allow_blank: true, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 1_000_000_000_000_000 }

  def validate_at_least_one_fields_except_as_of_present
    return unless %w[
      borrowers_count female_borrowers_count rural_borrowers_count number_of_micro_borrowers number_of_sme_borrowers
      avg_loan_size internal_impact_score number_of_clients
    ].all? { |attr| self[attr].blank? }

    errors.add(:base, 'At least one parameter must be present for the model to be saved')
  end
end
