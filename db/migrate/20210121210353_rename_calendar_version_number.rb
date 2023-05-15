class RenameCalendarVersionNumber < ActiveRecord::Migration[6.0]
  def change
    rename_column :repayment_calendars, :version, :version_number
  end
end
