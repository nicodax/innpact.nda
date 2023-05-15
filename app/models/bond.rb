# frozen_string_literal: true

class Bond < ApplicationRecord
  acts_as_paranoid

  belongs_to :fund
  has_many :executed_loan_versions, dependent: :restrict_with_error, class_name: 'LoanVersion', foreign_key: 'executed_bond_id'
  has_many :approved_loan_versions, dependent: :restrict_with_error, class_name: 'LoanVersion', foreign_key: 'approved_bond_id'

  validates :name, presence: true, uniqueness: { conditions: -> {
                                                               with_deleted
                                                             }, scope: :fund_id }, length: { maximum: 30 }
  validates :description, presence: true, length: { maximum: 100 }
end
