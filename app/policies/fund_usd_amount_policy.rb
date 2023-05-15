# frozen_string_literal: true

class FundUsdAmountPolicy < ApplicationPolicy
  def new?
    admin_or_general_manager
  end

  def create?
    admin_or_general_manager
  end
end
