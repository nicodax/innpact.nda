# frozen_string_literal: true

DeletedFundPolicy = Struct.new(:user, :deleted_fund) do
  def index?
    user.administrator?
  end

  def show?
    user.administrator?
  end
end
