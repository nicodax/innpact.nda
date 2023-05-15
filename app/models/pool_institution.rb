# frozen_string_literal: true

class PoolInstitution < ApplicationRecord
  acts_as_paranoid

  belongs_to :pool
  belongs_to :institution

  validates :pool_id, uniqueness: { scope: :institution_id }
end
