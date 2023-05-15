# frozen_string_literal: true

class Currency < ApplicationRecord
  acts_as_paranoid
  belongs_to :fund
  has_many :pools, dependent: :restrict_with_error
  has_many :loan_versions, dependent: :restrict_with_error

  validates :short_name, presence: true, uniqueness: { conditions: -> {
                                                                     with_deleted
                                                                   }, scope: :fund_id }, length: { is: 3 }
  validates :name, length: { maximum: 50 }
  validates :priority, numericality: { greater_than: 0, less_than: 10 }, allow_blank: true

  has_many :currency_rates, inverse_of: :currency, dependent: :destroy
  has_many :current_currency_rates, -> { current }, class_name: 'CurrencyRate', inverse_of: :currency, dependent: :destroy
  has_many :expired_currency_rates, -> { expired }, class_name: 'CurrencyRate', inverse_of: :currency, dependent: :destroy
  accepts_nested_attributes_for :currency_rates

  has_many :currency_countries, dependent: :destroy
  has_many :countries, through: :currency_countries

  accepts_nested_attributes_for :currency_countries

  def current_rate
    self.current_currency_rates.first.try(:rate) || 0
  end

  def current_timestamp
    self.currency_rates.last.created_at.to_date
  end

  def deleted?
    deleted_at.present?
  end
end
