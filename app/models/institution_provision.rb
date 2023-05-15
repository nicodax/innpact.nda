# frozen_string_literal: true

class InstitutionProvision < ApplicationRecord
  acts_as_paranoid

  VERSION_STATUS_TEMPORARY = 'temporary'
  VERSION_STATUS_VALIDATED = 'validated'
  VERSION_STATUS_REJECTED = 'rejected'

  belongs_to :creation_user, class_name: 'User'
  belongs_to :institution

  has_many :loan_provisions, dependent: :destroy

  attr_accessor :currency_value

  validates_presence_of :percentage, :comment, :previous_percentage_of_provision, :new_percentage_of_provision

  scope :validated, -> { where(version_status: VERSION_STATUS_VALIDATED) }
  scope :rejected, -> { where(version_status: VERSION_STATUS_REJECTED) }
  scope :temporary, -> { where(version_status: VERSION_STATUS_TEMPORARY) }

  def validated?
    version_status == VERSION_STATUS_VALIDATED
  end

  def rejected?
    version_status == VERSION_STATUS_REJECTED
  end

  def temporary?
    version_status == VERSION_STATUS_TEMPORARY
  end
end
