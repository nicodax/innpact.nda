# frozen_string_literal: true

class FundPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    admin_or_general_manager || record.members_ids.include?(user.id) || (reader? && record.users.exists?(id: user.id))
  end

  def create?
    user.administrator?
  end

  def new?
    create?
  end

  def update?
    user.administrator?
  end

  def edit?
    update?
  end

  def archive?
    user.administrator?
  end

  def destroy?
    user.administrator?
  end

  def enable?
    user.administrator?
  end

  class Scope
    def initialize(user, scope)
      @user  = user
      @scope = scope
    end

    def resolve
      if user.administrator? || user.general_manager?
        scope.active
      else
        if user.reader?
          scope.active.where(id: user.funds.select(:id).distinct)
        else
          scope.active.where(id: user.im_groups.select(:fund_id).distinct)
        end
      end
    end

    private

    attr_reader :user, :scope
  end
end
