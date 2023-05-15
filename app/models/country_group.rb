# frozen_string_literal: true

class CountryGroup < ApplicationRecord
  acts_as_paranoid
  before_destroy :check_for_country

  belongs_to :fund
  has_many :countries, dependent: :destroy

  validates :name, presence: true, uniqueness: { conditions: lambda {
                                                               with_deleted
                                                             }, scope: :fund_id }, length: { maximum: 30 }
  validates :description, length: { maximum: 100 }

  private

  def check_for_country
    if countries.count > 0
      errors.add(:base, I18n.t('activerecord.errors.nested_object_prevent_deletion',
                               object_name: I18n.t('activerecord.models.country_group.one'),
                               nested_objects: I18n.t('activerecord.models.country.other')))
      throw(:abort)
    end
  end
end
