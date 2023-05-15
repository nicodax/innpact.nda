# frozen_string_literal: true

class InterestRateType < ApplicationRecord
  acts_as_paranoid
  validates :name, presence: true, uniqueness: { conditions: -> {
                                                               with_deleted
                                                             }, scope: :fund_id }, length: { maximum: 30 }
  validates :description, presence: true, length: { maximum: 100 }

  belongs_to :fund

  has_many :loan_versions, dependent: :restrict_with_error
  has_many :executed_loan_versions, dependent: :restrict_with_error, class_name: 'LoanVersion', foreign_key: 'loan_interest_rate_type_id'
  has_many :approved_loan_versions, dependent: :restrict_with_error, class_name: 'LoanVersion', foreign_key: 'approved_interest_rate_type_id'
end
