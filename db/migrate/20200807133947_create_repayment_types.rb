class CreateRepaymentTypes < ActiveRecord::Migration[6.0]
  def change
    create_table :repayment_types do |t|
      t.string :name

      t.timestamps
    end
  end
end
