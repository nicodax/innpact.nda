class AddCreationUserToRepaymentCalendar < ActiveRecord::Migration[6.0]
  def change
    add_reference :repayment_calendars, :creation_user, foreign_key: { to_table: :users }
    change_column :repayment_calendars, :creation_user_id, :bigint, null: false
  end
end
