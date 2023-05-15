# frozen_string_literal: true

class CurrencyPolicy < SettingPolicy
  def import?
    admin_or_general_manager
  end
end
