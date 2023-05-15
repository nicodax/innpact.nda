# frozen_string_literal: true

class PoolTarget < ApplicationRecord
  acts_as_paranoid

  belongs_to :pool

  validates :is_target_in_usd_or_percent, presence: true
  if :check_target_type_USD
    validates :amount_in_usd, presence: true, numericality: { greater_than: 0, less_than: 1000000000000000 },
                              unless: :amount_in_percent
  end
  if :check_target_type_percent
    validates :amount_in_percent, presence: true, numericality: { greater_than: 0, less_than: 100 },
                                  unless: :amount_in_usd
  end
  validate :USD_or_percent
  validate :USD_and_percent

  def USD_or_percent
    errors.add(:base,
               I18n.t("settings.pool_targets.USD_or_percent")) unless amount_in_percent.present? || amount_in_usd.present?
  end

  def USD_and_percent
    errors.add(:base,
               I18n.t("settings.pool_targets.USD_and_percent")) if amount_in_percent.present? && amount_in_usd.present?
  end

  def check_target_type_USD
    if amount_in_usd.present?
      errors.add(:base, I18n.t("settings.pool_targets.check_target_type_USD")) if is_target_in_usd_or_percent != "USD"
    end
  end

  def check_target_type_percent
    if amount_in_percent.present?
      errors.add(:base,
                 I18n.t("settings.pool_targets.check_target_type_percent")) if is_target_in_usd_or_percent != "Percent"
    end
  end
end
