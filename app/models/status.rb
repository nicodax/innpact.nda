# frozen_string_literal: true

class Status < ApplicationRecord
  acts_as_paranoid
  belongs_to :user
  belongs_to :fund

  validates :name, presence: true, uniqueness: { conditions: -> { with_deleted }, scope: :fund_id }
end
