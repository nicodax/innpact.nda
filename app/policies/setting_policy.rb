# frozen_string_literal: true

class SettingPolicy < ApplicationPolicy
  def index?
    admin_or_general_manager || reader?
  end

  def show?
    admin_or_general_manager || reader?
  end

  def create?
    admin_or_general_manager
  end

  def new?
    create?
  end

  def update?
    admin_or_general_manager
  end

  def edit?
    update?
  end

  def destroy?
    admin_or_general_manager
  end

  def restore?
    destroy?
  end
end
