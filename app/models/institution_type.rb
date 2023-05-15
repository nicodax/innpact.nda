# frozen_string_literal: true

class InstitutionType < ApplicationRecord
  acts_as_paranoid

  belongs_to :fund
  has_many :institution, dependent: :restrict_with_error

  validates :name, presence: true, uniqueness: { conditions: lambda { with_deleted }, scope: :fund_id }, length: { maximum: 30 }

  validates :description, length: { maximum: 100 }
end
