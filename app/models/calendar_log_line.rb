# frozen_string_literal: true

class CalendarLogLine < ApplicationRecord
  acts_as_paranoid # soft delete

  ACTION_CREATION = "creation"
  ACTION_UPDATE = "update"
  ACTION_DELETION = "deletion"
  ACTION_VALIDATION = "validation"
  ACTION_REJECTION = "rejection"
  ACTION_INSTITUTION_PROVISION = "institution_provision"

  belongs_to :calendar_log
  belongs_to :original_repayment_line, class_name: "RepaymentCalendarLine", optional: true
  belongs_to :new_repayment_line, class_name: "RepaymentCalendarLine", optional: true
end
