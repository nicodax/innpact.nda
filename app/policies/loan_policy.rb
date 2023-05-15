# frozen_string_literal: true

class LoanPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    admin_or_general_manager || im_group_member? || reader?
  end

  def create?
    admin_or_general_manager || im_group_member?
  end

  def new?
    create?
  end

  def update?
    admin_or_general_manager || im_group_member?
  end

  def edit?
    update?
  end

  def validate_or_reject?
    admin_or_general_manager
  end

  def destroy?
    admin_or_general_manager || creator_or_assigned
  end

  def waiting_list_change?
    user.general_manager? || user.administrator?
  end

  def creator_or_assigned
    user == record.creation_user
  end

  def active_version_validated
    record.active_loan_version.validated?
  end

  def administrator?
    user.administrator?
  end

  class Scope
    def initialize(user, scope)
      @user  = user
      @scope = scope
    end

    def resolve
      current_scope = scope.includes(:institution, :im_group, loan_versions: %i[currency pool repayment_type executed_bond
                                                                                approved_bond loan_interest_rate_type
                                                                                approved_interest_rate_type loan_type])

      if user.investment_manager?
        return current_scope.where(im_group: user.im_group_ids)
      end

      current_scope
    end

    private

    attr_reader :user, :scope
  end
end
