# frozen_string_literal: true

class UserPolicy < SettingPolicy
  def update?
    user.administrator? || user.general_manager? && !record.administrator?
  end

  def destroy?
    user.administrator? || user.general_manager? && !record.administrator?
  end
end
