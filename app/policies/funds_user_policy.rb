# frozen_string_literal: true

class FundsUserPolicy < ApplicationPolicy
  def show?
    user.administrator? || user.general_manager?
  end
end
