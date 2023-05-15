# frozen_string_literal: true

class PoolCurrency < ApplicationRecord
  acts_as_paranoid

  belongs_to :pool
  belongs_to :currency

  validates :pool_id, uniqueness: { scope: :currency_id }
end
