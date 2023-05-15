# frozen_string_literal: true

class ImGroup < ApplicationRecord
  belongs_to :fund
  has_many :loans
  has_many :institutions
  has_many :im_groups_users
  has_and_belongs_to_many :users

  validates :name, presence: true, uniqueness: { scope: :fund_id }, length: { maximum: 100 }

  def assigned?
    loans.exists? || institutions.exists?
  end
end
