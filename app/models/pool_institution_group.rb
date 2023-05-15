# frozen_string_literal: true

class PoolInstitutionGroup < ApplicationRecord
  acts_as_paranoid

  belongs_to :pool
  belongs_to :institution_group

  validates :pool_id, uniqueness: { scope: :institution_group_id }
end
