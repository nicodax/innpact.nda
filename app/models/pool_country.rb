# frozen_string_literal: true

class PoolCountry < ApplicationRecord
  acts_as_paranoid

  belongs_to :pool
  belongs_to :country

  validates :pool_id, uniqueness: { scope: :country_id }
end
