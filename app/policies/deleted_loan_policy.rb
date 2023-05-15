# frozen_string_literal: true

class DeletedLoanPolicy < ApplicationPolicy
  def index?
    admin_or_general_manager
  end

  def show?
    admin_or_general_manager
  end

  def update?
    admin_or_general_manager
  end

  def destroy?
    admin_or_general_manager
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
