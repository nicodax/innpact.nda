# frozen_string_literal: true

class CountryPolicy < SettingPolicy
  def create?
    admin_or_general_manager
  end

  def edit?
    admin_or_general_manager
  end

  def import?
    admin_or_general_manager
  end
end
