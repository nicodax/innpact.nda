# frozen_string_literal: true

class PoolLoanType < ApplicationRecord
  acts_as_paranoid

  belongs_to :pool
  belongs_to :loan_type

  validates :pool_id, uniqueness: { scope: :loan_type_id }
end
