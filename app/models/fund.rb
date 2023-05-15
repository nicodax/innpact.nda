# frozen_string_literal: true

class Fund < ApplicationRecord
  acts_as_paranoid # soft delete

  # before_destroy { users.clear }

  # Retrieve users assigned to the fund
  # has_and_belongs_to_many :users, -> { distinct }, inverse_of: :funds
  has_many :fund_usd_amounts, dependent: :destroy
  has_many :loans, dependent: :destroy

  has_many :countries, dependent: :destroy
  has_many :bonds, dependent: :destroy
  has_many :country_groups, dependent: :destroy
  has_many :institutions, dependent: :destroy
  has_many :institution_groups, dependent: :destroy
  has_many :institution_types, dependent: :destroy
  has_many :institution_covenants, dependent: :destroy, through: :institutions
  # TODO : TO BE DELETED AFTER REFACTORING
  # has_many :institution_esg_sdg_contributions, dependent: :destroy, through: :institutions
  has_many :institution_esg_gender_equalities, dependent: :destroy, through: :institutions
  has_many :institution_esg_safeguards, dependent: :destroy, through: :institutions
  has_many :institution_esg_risks, dependent: :destroy, through: :institutions
  has_many :institution_esg_pai_indicators, dependent: :destroy, through: :institutions
  # TODO : TO BE DELETED AFTER REFACTORING
  # has_many :institution_profiles, dependent: :destroy, through: :institutions
  has_many :institution_ratings, dependent: :destroy, through: :institutions
  has_many :institution_financials, dependent: :destroy, through: :institutions
  has_many :institution_distribution_by_sectors, dependent: :destroy, through: :institutions
  has_many :currencies, dependent: :destroy
  has_many :currency_rates, through: :currencies
  has_many :default_limits, dependent: :destroy
  has_many :limit_exceptions, dependent: :destroy
  has_many :interest_rate_types, dependent: :destroy
  has_many :loan_types, dependent: :destroy
  has_many :pools, dependent: :destroy
  has_many :repayment_types, dependent: :destroy
  has_many :statuses, dependent: :destroy
  has_many :im_groups
  has_many :funds_users, dependent: :destroy
  has_many :users, through: :funds_users

  enum status: %i[active inactive soft_deleted]

  validates :name, presence: true

  scope :for_user, ->(user_id) {
    joins(im_groups: %i[im_groups_users users]).where('users.id': user_id).select('funds.*').distinct
  }

  def current_amount
    fund_usd_amounts.order(created_at: :desc).first
  end

  def members_ids
    im_groups.joins(:im_groups_users).pluck(:user_id)
  end

  def readers_ids
    users.pluck(:user_id)
  end

  def readers_ids=(ids)
    self.users = []

    ids.each do |id|
      funds_users.build(user_id: id)
    end
  end
end
