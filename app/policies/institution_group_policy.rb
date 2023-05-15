# frozen_string_literal: true

class InstitutionGroupPolicy < SettingPolicy
  def index?
    admin_or_general_manager_or_investment_manager || reader?
  end

  def show?
    admin_or_general_manager_or_investment_manager || reader?
  end

  def create?
    admin_or_general_manager_or_investment_manager
  end

  def new?
    create?
  end

  def update?
    admin_or_general_manager_or_investment_manager
  end

  def edit?
    update?
  end

  def destroy?
    admin_or_general_manager_or_investment_manager
  end

  private

  def admin_or_general_manager_or_investment_manager
    user.administrator? || user.general_manager? || user.investment_manager?
  end
end
