# frozen_string_literal: true

class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    false
  end

  def show?
    false
  end

  def create?
    false
  end

  def new?
    create?
  end

  def update?
    false
  end

  def edit?
    update?
  end

  def destroy?
    false
  end

  protected

  def admin_or_general_manager
    @admin_or_general_manager ||= user.administrator? || user.general_manager?
  end

  def reader?
    user.reader?
  end

  # Make auth for the resource's instances
  def im_group_member?
    @im_group_member ||= record.respond_to?(:im_group) && record.im_group.user_ids.include?(user.id)
  end

  # Make auth for the static classes e.g index?
  def im_group_assigned?
    record.where(im_group_id: user.im_group_ids).exists?
  end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      scope.all
    end
  end
end
