class AddPreviousVersionLineIdToRepaymentCalendarLines < ActiveRecord::Migration[6.0]
  def change
    add_reference :repayment_calendar_lines, :previous_version_line,
                  foreign_key: { to_table: :repayment_calendar_lines }
  end
end
