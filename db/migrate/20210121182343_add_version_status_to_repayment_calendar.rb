class AddVersionStatusToRepaymentCalendar < ActiveRecord::Migration[6.0]
  def change
    add_column :repayment_calendars, :version_status, :string, default: 'temporary', null: false
    add_reference :repayment_calendars, :validation_user, foreign_key: { to_table: :users }
    add_reference :repayment_calendars, :rejection_user, foreign_key: { to_table: :users }
  end
end
