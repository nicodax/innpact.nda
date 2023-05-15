# frozen_string_literal: true

class FundUsdAmount < ApplicationRecord
  acts_as_paranoid
  belongs_to :fund

  validates :amount, presence: true
  validates :amount, numericality: { greater_than_or_equal_to: 0 }
end
