# frozen_string_literal: true

class RepaymentType < ApplicationRecord
  acts_as_paranoid
  belongs_to :fund

  validates :name, presence: true, uniqueness: { conditions: -> {
                                                               with_deleted
                                                             }, scope: :fund_id }, length: { maximum: 30 }
  validates :description, presence: true, length: { maximum: 100 }

  has_many :loan_versions, dependent: :restrict_with_error
end
