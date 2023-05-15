# frozen_string_literal: true

InactiveFundPolicy = Struct.new(:user, :inactive_fund) do
  def index?
    user.administrator?
  end

  def show?
    user.administrator?
  end
end
