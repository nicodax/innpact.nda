# frozen_string_literal: true

DeletedItemPolicy = Struct.new(:user, :deleted_item) do
  def index?
    user.administrator? || user.general_manager?
  end

  def show?
    user.administrator? || user.general_manager?
  end

  def destroy?
    user.administrator? || user.general_manager?
  end

  def restore?
    user.administrator? || user.general_manager?
  end
end
