# frozen_string_literal: true

class User < ApplicationRecord
  ROLE_ADMINISTRATOR = 'administrator'
  ROLE_GENERAL_MANAGER = 'general_manager'
  ROLE_INVESTMENT_MANAGER = 'investment_manager'
  ROLE_READER = 'reader'
  ROLE_SYSTEM = 'system'
  ROLES = [ROLE_ADMINISTRATOR, ROLE_GENERAL_MANAGER, ROLE_INVESTMENT_MANAGER, ROLE_READER, ROLE_SYSTEM].freeze

  rolify
  acts_as_paranoid # soft delete
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # has_many :institution_groups, dependent: :restrict_with_error

  # Retrieve funds the user has been assigned to
  has_many :loans, dependent: :restrict_with_error, inverse_of: :creation_user, foreign_key: :creation_user_id
  has_many :loan_versions, dependent: :restrict_with_error, inverse_of: :rejection_user, foreign_key: :rejection_user_id
  has_many :repayment_calendars, dependent: :restrict_with_error, inverse_of: :rejection_user,
                                 foreign_key: :rejection_user_id
  has_many :institution_provisions, dependent: :restrict_with_error, inverse_of: :creation_user,
                                    foreign_key: :creation_user_id
  has_many :loan_provisions, dependent: :restrict_with_error, inverse_of: :creation_user, foreign_key: :creation_user_id

  has_many :dashboard_notifications, dependent: :destroy

  has_and_belongs_to_many :im_groups

  has_many :funds_users, dependent: :destroy
  has_many :funds, through: :funds_users

  has_one :user_setting, dependent: :delete

  before_destroy { im_groups.clear }

  validates :email, :firstname, :lastname, presence: true
  validates :email, uniqueness: { conditions: -> { with_deleted } }

  validate :allowed_to_unsubscribe

  scope :assigned_to_institution, lambda { |institution|
    joins(:institutions).where('institutions.id' => institution.id)
  }

  scope :for_fund, lambda { |fund_id|
    joins(:im_groups).where('im_groups.fund_id': fund_id).select('users.*, im_groups.fund_id')
  }

  scope :administrator, -> { joins(:roles).where('roles.name' => ROLE_ADMINISTRATOR) }

  scope :general_manager, -> { joins(:roles).where('roles.name' => ROLE_GENERAL_MANAGER) }

  scope :system, -> { joins(:roles).where('roles.name' => ROLE_SYSTEM) }

  accepts_nested_attributes_for :user_setting

  def user_setting
    super || build_user_setting(
      loans_crud: 1,
      loans_validation: 1,
      provisions_crud: 1,
      provisions_validation: 1,
      repayments_crud: 1,
      repayments_validation: 1
    )
  end

  def full_name
    "#{firstname} #{lastname}"
  end

  def role
    roles.first
  end

  def can_give_role?(role)
    administrator? || role != :administrator
  end

  def im_group_for_fund(fund:)
    im_groups.where(fund_id: fund.id).first
  end

  ROLES.each do |role|
    define_method "#{role}?" do
      has_cached_role?(role)
    end
  end

  def allowed_to_unsubscribe_validation?
    !not_allowed_to_unsubscribe_validation?
  end

  def not_allowed_to_unsubscribe_validation?
    administrator? || general_manager?
  end

  def allowed_to_unsubscribe
    return unless not_allowed_to_unsubscribe_validation? &&
                  (!user_setting.allows_loans_validation_mail? ||
                  !user_setting.allows_repayments_validation_mail? ||
                  !user_setting.allows_provisions_validation_mail?)

    errors.add(:user_setting, :not_allowed_to_unsubscribe)
  end
end
