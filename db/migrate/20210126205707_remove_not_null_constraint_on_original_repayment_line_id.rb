class RemoveNotNullConstraintOnOriginalRepaymentLineId < ActiveRecord::Migration[6.0]
  def change
    change_column_null :calendar_log_lines, :original_repayment_line_id, true
  end
end
