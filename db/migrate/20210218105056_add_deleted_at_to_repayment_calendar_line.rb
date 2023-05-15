class AddDeletedAtToRepaymentCalendarLine < ActiveRecord::Migration[6.0]
  def change
    add_column :repayment_calendar_lines, :deleted_at, :datetime
    add_column :calendar_logs, :deleted_at, :datetime
    add_column :calendar_log_lines, :deleted_at, :datetime
  end
end
