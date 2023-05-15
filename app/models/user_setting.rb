# frozen_string_literal: true

class UserSetting < ApplicationRecord
  belongs_to :user

  def allows_loans_crud_mail?
    !loans_crud.zero?
  end

  def allows_loans_validation_mail?
    !loans_validation.zero?
  end

  def allows_repayments_crud_mail?
    !repayments_crud.zero?
  end

  def allows_repayments_validation_mail?
    !repayments_validation.zero?
  end

  def allows_provisions_crud_mail?
    !provisions_crud.zero?
  end

  def allows_provisions_validation_mail?
    !provisions_validation.zero?
  end
end
