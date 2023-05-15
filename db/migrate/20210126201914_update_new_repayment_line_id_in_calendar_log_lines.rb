class UpdateNewRepaymentLineIdInCalendarLogLines < ActiveRecord::Migration[6.0]
  def change
    remove_column :calendar_log_lines, :new_repayment_line
    add_reference :calendar_log_lines, :new_repayment_line, foreign_key: { to_table: :repayment_calendar_lines },
                                                            null: false
  end
end
