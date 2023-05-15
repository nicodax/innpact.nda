# frozen_string_literal: true

class LoanRequestDocumentPolicy < ApplicationPolicy
  def index?
    admin_or_general_manager || creator_or_assigned || reader?
  end

  def show?
    admin_or_general_manager || creator_or_assigned || reader?
  end

  def create?
    admin_or_general_manager || creator_or_assigned
  end

  def new?
    create?
  end

  def update?
    admin_or_general_manager || creator_or_assigned
  end

  def edit?
    update?
  end

  def destroy?
    admin_or_general_manager || creator_or_assigned
  end

  def restore?
    destroy?
  end

  def preview?
    show?
  end

  def creator_or_assigned
    user == record.loan_request.assigned_investment_manager || user == record.loan_request.user
  end
end
