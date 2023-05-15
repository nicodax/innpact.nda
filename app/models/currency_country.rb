# frozen_string_literal: true

class CurrencyCountry < ApplicationRecord
  acts_as_paranoid

  belongs_to :currency
  belongs_to :country

  validates :currency_id, uniqueness: { scope: :country_id }
end
