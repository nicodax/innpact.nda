# frozen_string_literal: true

class DefaultLimit < ApplicationRecord
  acts_as_paranoid
  belongs_to :fund

  validates_presence_of :model, :value
  validates :value, uniqueness: { scope: [:model, :fund_id] }
  validates :description, length: { maximum: 100 }, presence: true
end
