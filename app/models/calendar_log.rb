# frozen_string_literal: true

class CalendarLog < ApplicationRecord
  acts_as_paranoid # soft delete

  belongs_to :repayment_calendar
  belongs_to :creation_user, class_name: "User"

  has_many :lines, class_name: "CalendarLogLine", inverse_of: :calendar_log, dependent: :destroy

  accepts_nested_attributes_for :lines
end
