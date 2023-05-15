# frozen_string_literal: true

class Country < ApplicationRecord
  acts_as_paranoid
  include HasLimitExceptions
  # TODO [07/09/2020] [AFR] - add foreign key to Limit Exceptions (Countries, institutions, institution_groups) instead of using model
  # before_destroy :check_for_limit_exception
  belongs_to :fund
  belongs_to :country_group, optional: true

  has_many :pool_countries
  has_many :pools, through: :pool_countries, dependent: :restrict_with_error
  has_many :currency_countries, dependent: :destroy
  has_many :institutions, dependent: :restrict_with_error
  # TODO [07/09/2020] [AFR] - add foreign key to Limit Exceptions (Countries, institutions, institution_groups) instead of using model
  # has_many :limit_exceptions

  validates_presence_of :limit
  validates :name, presence: true, uniqueness: { conditions: lambda {
                                                               with_deleted
                                                             }, scope: :fund_id }, length: { maximum: 30 }
  validates :iso_code, presence: true, uniqueness: { conditions: -> { with_deleted }, scope: :fund_id }
  validates :population, allow_nil: true, numericality: { greater_than_or_equal_to: 0, less_than: 10_000_000_000 }
  validates :gdp, allow_nil: true, numericality: { greater_than_or_equal_to: 0, less_than: 1_000_000_000_000_000 }
  validates :gdp_per_capita, allow_nil: true,
                             numericality: { greater_than_or_equal_to: 0, less_than: 1_000_000_000_000_000 }
  validates :gni, allow_nil: true, numericality: { greater_than_or_equal_to: 0, less_than: 1_000_000_000_000_000 }
  validates :gni_per_capita, allow_nil: true,
                             numericality: { greater_than_or_equal_to: 0, less_than: 1_000_000_000_000_000 }
  validates :mimosa_score, allow_nil: true, numericality: { greater_than: 0, less_than: 10 }

  scope :high_incomes, -> { where(is_a_high_income_country: true) }
  scope :low_incomes, -> { where(is_a_high_income_country: false) }

  def limit
    exception = LimitException.find_by(model: 'country', model_id: id)
    default = DefaultLimit.find_by(model: 'country')

    exception&.value || default&.value || 'There is currently no limit assigned to this country'
  end
end
