class CreateCalendarLogs < ActiveRecord::Migration[6.0]
  def change
    create_table :calendar_logs do |t|
      t.references :repayment_calendar, null: false
      t.references :creation_user, foreign_key: { to_table: :users }, null: false

      t.timestamps
    end

    create_table :calendar_log_lines do |t|
      t.references :calendar_log, null: false
      t.string :action, null: false
      t.references :original_repayment_line, foreign_key: { to_table: :repayment_calendar_lines }, null: false
      t.string :new_repayment_line, foreign_key: { to_table: :repayment_calendar_lines }, null: false
      t.string :changed_attribute, null: false
      t.string :original_value, null: false
      t.string :new_value, null: false

      t.timestamps
    end
  end
end
