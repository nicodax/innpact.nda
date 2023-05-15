class RemoveNotNullConstraintInCalendarLogLines < ActiveRecord::Migration[6.0]
  def change
    change_column_null :calendar_log_lines, :changed_attribute, true
    change_column_null :calendar_log_lines, :original_value, true
    change_column_null :calendar_log_lines, :new_value, true
  end
end
