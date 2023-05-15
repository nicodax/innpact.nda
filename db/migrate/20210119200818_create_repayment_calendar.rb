class CreateRepaymentCalendar < ActiveRecord::Migration[6.0]
  def change
    create_table :repayment_calendars do |t|
      t.references :loan, null: false
      t.integer :version, null: false, default: 1

      t.timestamps
    end

    create_table :repayment_calendar_lines do |t|
      t.references :repayment_calendar, null: false
      t.date :repayment_date, null: false
      t.string :repayment_type, null: false
      t.float :original_amount, null: false
      t.float :received_amount, null: false, default: 0
      t.string :status, null: false, default: 'pending'
      t.float :provision, null: false, default: 0

      t.timestamps
    end
  end
end
