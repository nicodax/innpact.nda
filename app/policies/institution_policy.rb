# frozen_string_literal: true

class InstitutionPolicy < SettingPolicy
  def index?
    admin_or_general_manager || im_group_assigned? || reader?
  end

  def import?
    admin_or_general_manager || im_group_member?
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

  def upload?
    admin_or_general_manager || im_group_member?
  end

  def edit?
    update?
  end

  def destroy?
    admin_or_general_manager
  end

  private

  class Scope
    def initialize(user, scope)
      @user  = user
      @scope = scope
    end

    def resolve
      if user.general_manager? || user.administrator? || user.reader?
        scope.all
      else
        scope.where(im_group_id: user.im_group_ids)
      end
    end

    private

    attr_reader :user, :scope
  end
end
