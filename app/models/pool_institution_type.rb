# frozen_string_literal: true

class PoolInstitutionType < ApplicationRecord
  acts_as_paranoid

  belongs_to :pool
  belongs_to :institution_type

  validates :pool_id, uniqueness: { scope: :institution_type_id }
end
