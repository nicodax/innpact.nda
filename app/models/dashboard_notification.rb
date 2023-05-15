# frozen_string_literal: true

class DashboardNotification < ApplicationRecord
  belongs_to :user

  CREATED_LOAN_REQUEST_TYPE = "created_loan_request"
  ASSIGNED_LOAN_REQUEST_TYPE = "assigned_loan_request"
  SUBMITTED_LOAN_REQUEST_TYPE = "submitted_loan_request"

  scope :unchecked, -> { where(checked_at: nil) }
  scope :for_user, ->(user) { where(user_id: user.id) }

  def notification_object
    notification_object_type.constantize.where(id: notification_object_id).first
  end

  def check
    self.update!(checked_at: DateTime.now)
  end
end
