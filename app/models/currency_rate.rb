# frozen_string_literal: true

class CurrencyRate < ApplicationRecord
  acts_as_paranoid

  validates :rate, presence: true
  validates :rate, presence: true, numericality: { equal_to: 1, message: " value must be equal to 1 for USD" },
                   if: :is_USD?

  after_create :expire_old_record

  belongs_to :currency

  scope :current, -> { where(expired_date: nil) }
  scope :expired, -> { where.not(expired_date: nil).order(created_at: :desc) }

  def display_name
    "#{name} - #{rate} - #{created_at.to_date}"
  end

  def history_display_name
    "#{number_with_precision(rate, precision: 2, delimiter: ",")} - #{created_at.to_date} - #{created_by}"
  end

  def name
    Currency.with_deleted.find(currency_id).short_name
  end

  def deleted_parent
    Currency.only_deleted.where(id: currency_id).first
  end

  private

  def is_USD?
    currency.short_name.eql? "USD"
  end

  def expire_old_record
    CurrencyRate.where(currency_id: self.currency_id,
                       expired_date: nil).where.not(id: self.id).update_all(expired_date: Date.today)
  end
end
