class AddDescriptionToRepaymentTypes < ActiveRecord::Migration[6.0]
  def change
    add_column :repayment_types, :description, :string
  end
end
