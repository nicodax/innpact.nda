# frozen_string_literal: true

class InstitutionCovenant < ApplicationRecord
  acts_as_paranoid

  EXCLUDED_ATTRIBUTES = %w[id institution_id name deleted_at created_at updated_at fund_id SysStartTime SysStartTime SysEndTime]

  belongs_to :institution, inverse_of: :institution_covenant

  validates :par30, allow_blank: true, numericality: { less_than: 100 }
  validates :par30_limit, allow_blank: true, numericality: { less_than: 100 }
  validates :par30_refy, allow_blank: true, numericality: { less_than: 100 }
  validates :par30_refy_limit, allow_blank: true, numericality: { less_than: 100 }
  validates :roa, allow_blank: true, numericality: { less_than: 100 }
  validates :roa_limit, allow_blank: true, numericality: { less_than: 100 }
  validates :adj_roa, allow_blank: true, numericality: { less_than: 100 }
  validates :adj_roa_limit, allow_blank: true, numericality: { less_than: 100 }
  validates :open_fx_exposure, allow_blank: true, numericality: { less_than: 100 }
  validates :open_fx_exposure_limit, allow_blank: true, numericality: { less_than: 100 }
  validates :open_loan_position, allow_blank: true, numericality: { less_than: 100 }
  validates :open_loan_position_limit, allow_blank: true, numericality: { less_than: 100 }
  validates :car, allow_blank: true, numericality: { less_than: 100 }
  validates :car_limit, allow_blank: true, numericality: { less_than: 100 }
  validates :deposits_liabilities, allow_blank: true, numericality: { less_than: 100 }
  validates :deposits_liabilities_limit, allow_blank: true, numericality: { less_than: 100 }
  validates :maturity_matching_if_applicable, allow_blank: true, numericality: { less_than: 100 }
  validates :maturity_matching_if_applicable_limit, allow_blank: true, numericality: { less_than: 100 }
  validates :liquid_assets_deposits_if_applicable, allow_blank: true, numericality: { less_than: 100 }
  validates :liquid_assets_deposits_if_applicable_limit, allow_blank: true, numericality: { less_than: 100 }

  validate :check_attributes_limites
  validate :check_attributes_limites_without_actual
  validate :check_nil_attributes


  def check_attributes_limites
    attributes.except(*EXCLUDED_ATTRIBUTES).each do |attr_name, attr_value|
      next if attr_name.include?("_limit")
      errors.add(:limit, "#{attr_name} is missing") if !attr_value.nil? && attributes["#{attr_name}_limit"].nil?
    end
  end

  def check_attributes_limites_without_actual
    attributes.except(*EXCLUDED_ATTRIBUTES).each do |attr_name, attr_value|
      next if attr_name.exclude?("_limit")
      errors.add(:actual, "#{attr_name.sub("_limit", "")} is missing") if !attr_value.nil? && attributes["#{attr_name.sub("_limit", "")}"].nil?
    end
  end

  def check_nil_attributes
    errors.add(:covenant, "cannot be empty") unless attributes.except(*EXCLUDED_ATTRIBUTES).values.any?
  end
end
