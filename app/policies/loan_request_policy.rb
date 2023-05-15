# frozen_string_literal: true

class LoanRequestPolicy < ApplicationPolicy
  def index?
    admin_or_general_manager || creator_or_assigned || reader?
  end

  def show?
    admin_or_general_manager || creator_or_assigned || reader?
  end

  def create?
    admin_or_general_manager || record.fund.users.include?(user)
  end

  def new?
    create?
  end

  def update?
    admin_or_general_manager || creator_or_assigned
  end

  def edit?
    update?
  end

  def destroy?
    admin_or_general_manager || creator_or_assigned
  end

  def waiting_list_change?
    user.general_manager? || user.administrator?
  end

  def creator_or_assigned
    user == record.loan_request.assigned_investment_manager || user == record.loan_request.user
  end

  class Scope
    def initialize(user, scope)
      @user  = user
      @scope = scope
    end

    def resolve
      if user.general_manager? || user.administrator?
        scope.all
      else
        scope.where('user_id = ? OR assigned_investment_manager_id = ?', user.id, user.id)
      end
    end

    private

    attr_reader :user, :scope
  end
end
