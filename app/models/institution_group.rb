# frozen_string_literal: true

class InstitutionGroup < ApplicationRecord
  # Model used for Institution group
  # At the start of the project, it was referenced only as "Group", and later on renamed to "Institution Group"

  acts_as_paranoid
  include HasLimitExceptions
  before_destroy :check_for_institution

  belongs_to :fund

  has_many :institutions, dependent: :restrict_with_error

  validates :name, presence: true, uniqueness: { conditions: -> { with_deleted }, scope: :fund_id }, length: { maximum: 100 }

  private

  def check_for_institution
    if institutions.count > 0
      errors.add(:base, I18n.t("activerecord.errors.nested_object_prevent_deletion",
                               object_name: I18n.t("activerecord.models.institution_group.one"),
                               nested_objects: I18n.t("activerecord.models.institution.other")))
      throw(:abort)
    end
  end
end
