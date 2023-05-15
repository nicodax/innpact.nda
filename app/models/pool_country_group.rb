# frozen_string_literal: true

class PoolCountryGroup < ApplicationRecord
  acts_as_paranoid

  belongs_to :pool
  belongs_to :country_group

  validates :pool_id, uniqueness: { scope: :country_group_id }
end
