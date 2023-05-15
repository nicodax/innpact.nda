class LinkRepaymentCalendarToLoanVersion < ActiveRecord::Migration[6.0]
  def up
    add_reference :repayment_calendars, :loan_version
    add_column :repayment_calendars, :deleted_at, :datetime
    remove_column :loans, :last_repayment_calendar_version, :int
    remove_column :repayment_calendars, :version_number, :int
  end
end
