class AddLastRepaymentCalendarVersionToLoan < ActiveRecord::Migration[6.0]
  def change
    add_column :loans, :last_repayment_calendar_version, :integer, null: false, default: 0
  end
end
