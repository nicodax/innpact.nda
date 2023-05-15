# frozen_string_literal: true

class LoanType < ApplicationRecord
  acts_as_paranoid
  belongs_to :fund
  has_many :loan_versions, dependent: :restrict_with_error
  #Length of maximum 30 is arbitrary but was added as a default fail safe value if the user try to enter a name too big.
  validates :name, presence: true, uniqueness: { conditions: -> { with_deleted }, scope: :fund_id }, length: { maximum: 30 }
end
