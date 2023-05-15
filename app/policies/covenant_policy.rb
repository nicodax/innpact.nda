# frozen_string_literal: true

class CovenantPolicy < SettingPolicy
  def index?
    admin_or_general_manager || im_group_assigned? || reader?
  end

  def new?
    create?
  end

  def create?
    admin_or_general_manager || im_group_assigned?
  end
end
