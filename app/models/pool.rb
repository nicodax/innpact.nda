# frozen_string_literal: true

class Pool < ApplicationRecord
  acts_as_paranoid

  validates :name, presence: true, uniqueness: { conditions: -> {
                                                               with_deleted
                                                             }, scope: :fund_id }, length: { maximum: 100, too_long: "%{count} #{I18n.t('activerecord.models.pool.too_long')}" }
  validates :subscription_date, presence: true
  validates :maturity_date, presence: true, if: :has_maturity_date
  validates :amount, presence: true, numericality: { greater_than: 0, less_than: 10_000_000_000 }
  validates :amount_in_usd, presence: true, numericality: { greater_than: 0, less_than: 10_000_000_000 }
  validate :subscription_date_cannot_be_in_the_future
  validate :maturity_date_cannot_be_in_the_past, if: :has_maturity_date
  validate :check_for_no_restrictions, if: :is_targeted
  validate :check_for_restrictions
  validate :unique_global_account?

  belongs_to :fund
  has_many :loan_versions, dependent: :restrict_with_error

  has_many :pool_targets, dependent: :destroy
  accepts_nested_attributes_for :pool_targets

  belongs_to :currency
  delegate :name, to: :currency, prefix: true

  has_many :pool_countries, dependent: :destroy
  has_many :countries, through: :pool_countries
  accepts_nested_attributes_for :pool_countries

  has_many :pool_institutions, dependent: :destroy
  has_many :institutions, through: :pool_institutions
  accepts_nested_attributes_for :pool_institutions

  has_many :pool_institution_groups, dependent: :destroy
  has_many :institution_groups, through: :pool_institution_groups
  accepts_nested_attributes_for :pool_institution_groups

  has_many :pool_institution_types, dependent: :destroy
  has_many :institution_types, through: :pool_institution_types
  accepts_nested_attributes_for :pool_institution_types

  has_many :pool_country_groups, dependent: :destroy
  has_many :country_groups, through: :pool_country_groups
  accepts_nested_attributes_for :pool_country_groups

  has_many :pool_currencies, dependent: :destroy
  has_many :currencies, through: :pool_currencies
  accepts_nested_attributes_for :pool_currencies

  has_many :pool_loan_types, dependent: :destroy
  has_many :loan_types, through: :pool_loan_types
  accepts_nested_attributes_for :pool_loan_types

  has_many :pool_documents, dependent: :destroy
  accepts_nested_attributes_for :pool_documents, reject_if: :document_required?, allow_destroy: true

  has_many :pool_legal_documents, dependent: :destroy
  accepts_nested_attributes_for :pool_legal_documents

  scope :global_account, ->(fund_id) { where(fund_id: fund_id).where(is_targeted: false) }
  scope :targeted, -> { where(is_targeted: true) }
  scope :compliant_with_institution, ->(institution) {
                                       left_outer_joins(:pool_institutions).where("pool_institutions.institution_id = ? OR pool_institutions.institution_id is NULL", institution.id)
                                                                           .left_outer_joins(:pool_institution_types).where("pool_institution_types.institution_type_id = ? OR pool_institution_types.institution_type_id is NULL", institution.institution_type_id)
                                                                           .left_outer_joins(:pool_institution_groups).where("pool_institution_groups.institution_group_id = ? OR pool_institution_groups.institution_group_id is NULL", institution.institution_group_id)
                                                                           .left_outer_joins(:pool_countries).where("pool_countries.country_id = ? OR pool_countries.country_id is NULL", institution.country_id)
                                                                           .where(is_targeted: true)
                                     }
  scope :compliant_with_loan_type, ->(loan_type) {
                                     left_outer_joins(:pool_loan_types).where("pool_loan_types.loan_type_id = ? OR pool_loan_types.loan_type_id is NULL", loan_type.id)
                                                                       .where(is_targeted: true)
                                   }
  scope :compliant_with_currency, ->(currency) { where(currency_id: currency.id).where(is_targeted: true) }

  def current_target
    pool_targets.order(created_at: :desc).first
  end

  def maturity_date_cannot_be_in_the_past
    return if maturity_date.nil? || maturity_date > Date.today

    errors.add(:maturity_date, "can't be in the past")
  end

  def unique_global_account?
    if !(Pool.global_account(self.fund_id).to_a - [self]).empty? && is_targeted == false
      errors.add(:is_targeted, "Only one global account allowed per Fund")
    end
  end

  def subscription_date_cannot_be_in_the_future
    return if subscription_date.nil? || subscription_date <= Date.today

    errors.add(:subscription_date, "can't be in the future")
  end

  def check_for_no_restrictions
    if pool_currencies.empty? && pool_loan_types.empty? && pool_country_groups.empty? && pool_institution_types.empty? && pool_institution_groups.empty? && pool_institutions.empty? && pool_countries.empty?
      errors.add(:base, "Pool is targeted, it must contain at least one restriction")
    end
  end

  def check_for_restrictions
    if !is_targeted
      if pool_currencies.any? || pool_loan_types.any? || pool_country_groups.any? || pool_institution_types.any? || pool_institution_groups.any? || pool_institutions.any? || pool_countries.any?
        errors.add(:base, "Pool is global, it must not contain restrictions")
      end
    end
  end

  def document_required?
    required_specific_reporting == false
  end

  private
end
