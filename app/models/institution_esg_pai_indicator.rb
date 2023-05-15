# frozen_string_literal: true

class InstitutionEsgPaiIndicator < ApplicationRecord
  acts_as_paranoid

  belongs_to :institution

  validates :as_of, presence: true

  # Decimal can be negative
  validates :scope_1_emissions, :scope_2_emissions, :scope_3_emissions, :carbon_footprint, :ghg_intensity_investee_companies,
            :energy_consumption_intensity_per_high_impact_climate_sector, :emissions_to_water, :hazardous_waste_ratio,
            allow_blank: true, numericality: { greater_than_or_equal_to: -1_000_000_000_000_000, less_than_or_equal_to: 1_000_000_000_000_000 }

  # Decimal in Percent
  validates :exposure_companies_active_in_fossil_fuel_sector, :share_of_non_renewable_energy_consumption_and_production,
            :activities_negatively_affecting_biodiversity_sensitive_areas,
            :violations_of_un_global_compact_principles_and_oecd_guidelines_for_multinational_enterprises,
            :lack_of_processes_and_compliance_mechanisms_to_monitor_compliance_with_un_global_compact_principles,
            :unadjusted_gender_pay_gap, :board_gender_diversity,
            :exposure_to_controversial_weapons,
            allow_blank: true, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }

  DECIMAL_VALIDATION_FIELDS = %w[scope_1_emissions scope_2_emissions scope_3_emissions carbon_footprint ghg_intensity_investee_companies
                                 energy_consumption_intensity_per_high_impact_climate_sector emissions_to_water
                                 hazardous_waste_ratio exposure_companies_active_in_fossil_fuel_sector
                                 share_of_non_renewable_energy_consumption_and_production
                                 activities_negatively_affecting_biodiversity_sensitive_areas
                                 violations_of_un_global_compact_principles_and_oecd_guidelines_for_multinational_enterprises
                                 lack_of_processes_and_compliance_mechanisms_to_monitor_compliance_with_un_global_compact_principles
                                 unadjusted_gender_pay_gap board_gender_diversity
                                 exposure_to_controversial_weapons].freeze

  PAI_REGEXP = /^-?\d*\.{0,1}\d{0,7}+$/
  validate :validate_decimal_fields_seven_digit_precision

  validate :validate_at_least_one_fields_except_as_of_present

  def validate_decimal_fields_seven_digit_precision
    DECIMAL_VALIDATION_FIELDS.each do |field|
      next unless read_attribute_before_type_cast(field).blank? == false &&
                  PAI_REGEXP.match(read_attribute_before_type_cast(field).to_s) == false

      errors.add(field, 'The input is invalid. There can only be 7 digits at most after the decimal point.')
    end
  end

  def sum_ghg_scope_emissions
    scope_1_emissions.to_f + scope_2_emissions.to_f + scope_3_emissions.to_f
  end

  def validate_at_least_one_fields_except_as_of_present
    return unless %w[
      scope_1_emissions scope_2_emissions scope_3_emissions carbon_footprint ghg_intensity_investee_companies
      exposure_companies_active_in_fossil_fuel_sector share_of_non_renewable_energy_consumption_and_production
      energy_consumption_intensity_per_high_impact_climate_sector
      activities_negatively_affecting_biodiversity_sensitive_areas emissions_to_water hazardous_waste_ratio
      violations_of_un_global_compact_principles_and_oecd_guidelines_for_multinational_enterprises
      lack_of_processes_and_compliance_mechanisms_to_monitor_compliance_with_un_global_compact_principles
      unadjusted_gender_pay_gap board_gender_diversity exposure_to_controversial_weapons
    ].all? { |attr| self[attr].blank? }

    errors.add(:base, 'At least one parameter must be present for the model to be saved')
  end
end
