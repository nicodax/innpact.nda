# frozen_string_literal: true

class AdditionalPaisSocial < ApplicationRecord
  acts_as_paranoid

  belongs_to :institution

  validates :as_of, presence: true

  validate :validate_at_least_one_fields_except_as_of_present

  validate :validate_both_value_and_reported_present

  validate :percent_not_exceeding_hundred_or_negative

  DECIMAL_VALIDATION_FIELDS = %w[social_pai_value].freeze

  PAI_REGEXP = /^-?\d*\.{0,1}\d{0,7}+$/
  validate :validate_decimal_fields_seven_digit_precision

  def validate_decimal_fields_seven_digit_precision
    DECIMAL_VALIDATION_FIELDS.each do |field|
      next unless read_attribute_before_type_cast(field).blank? == false &&
                  PAI_REGEXP.match(read_attribute_before_type_cast(field).to_s) == false

      errors.add(field, 'The input is invalid. There can only be 7 digits at most after the decimal point.')
    end
  end

  def self.additional_pai_social_units_map
    {
      'E01' => '%',
      'E02' => '%',
      'E03' => '#',
      'E04' => '%',
      'E05' => '%',
      'E06' => '%',
      'E07' => '#',
      'E08' => '%',
      'E09' => '%',
      'E10' => '%',
      'E11' => '%',
      'E12' => '%',
      'E13' => '%',
      'E14' => '#',
      'E15' => '%',
      'E16' => '%',
      'E17' => '#'
    }
  end

  def self.additional_pais_social_map
    {
      'E01' => I18n.t('settings.additional_pais_socials.shared.form.E1'),
      'E02' => I18n.t('settings.additional_pais_socials.shared.form.E2'),
      'E03' => I18n.t('settings.additional_pais_socials.shared.form.E3'),
      'E04' => I18n.t('settings.additional_pais_socials.shared.form.E4'),
      'E05' => I18n.t('settings.additional_pais_socials.shared.form.E5'),
      'E06' => I18n.t('settings.additional_pais_socials.shared.form.E6'),
      'E07' => I18n.t('settings.additional_pais_socials.shared.form.E7'),
      'E08' => I18n.t('settings.additional_pais_socials.shared.form.E8'),
      'E09' => I18n.t('settings.additional_pais_socials.shared.form.E9'),
      'E10' => I18n.t('settings.additional_pais_socials.shared.form.E10'),
      'E11' => I18n.t('settings.additional_pais_socials.shared.form.E11'),
      'E12' => I18n.t('settings.additional_pais_socials.shared.form.E12'),
      'E13' => I18n.t('settings.additional_pais_socials.shared.form.E13'),
      'E14' => I18n.t('settings.additional_pais_socials.shared.form.E14'),
      'E15' => I18n.t('settings.additional_pais_socials.shared.form.E15'),
      'E16' => I18n.t('settings.additional_pais_socials.shared.form.E16'),
      'E17' => I18n.t('settings.additional_pais_socials.shared.form.E17')
    }
  end

  def self.additional_pais_social_options
    additional_pais_social_map.collect { |k, v| [v, k, { 'data-unit': additional_pai_social_units_map[k] }] }
  end

  def validate_at_least_one_fields_except_as_of_present
    return unless %w[social_pai_reported social_pai_value].all? { |attr| self[attr].blank? }

    errors.add(:base, 'At least one parameter must be present for the model to be saved')
  end

  def validate_both_value_and_reported_present
    errors.add(:social_pai_reported, "This field can't be blank.") if social_pai_reported.blank? && social_pai_value.blank? == false
    errors.add(:social_pai_value, "This field can't be blank.") if social_pai_reported.blank? == false && social_pai_value.blank?
  end

  def percent_not_exceeding_hundred_or_negative
    return unless AdditionalPaisSocial.additional_pai_social_units_map[social_pai_reported] == '%' &&
                  social_pai_value.present? &&
                  (social_pai_value > 100 || social_pai_value.negative?)

    errors.add(:social_pai_value, "This field should be between 0% and 100%.")
  end
end
