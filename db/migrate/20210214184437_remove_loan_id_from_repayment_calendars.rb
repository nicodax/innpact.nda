class RemoveLoanIdFromRepaymentCalendars < ActiveRecord::Migration[6.0]
  def change
    remove_column :repayment_calendars, :loan_id
  end
end
