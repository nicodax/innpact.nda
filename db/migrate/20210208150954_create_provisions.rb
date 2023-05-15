class CreateProvisions < ActiveRecord::Migration[6.0]
  def change
    create_table :institution_provisions do |t|
      t.float :percentage, null: false
      t.float :previous_percentage_of_provision, null: false
      t.float :new_percentage_of_provision, null: false
      t.string :comment, null: false
      t.references :institution, null: false
      t.references :creation_user, foreign_key: { to_table: :users }, null: false
      t.datetime :deleted_at
      t.timestamps
    end

    create_table :loan_provisions do |t|
      t.float :percentage, null: false
      t.float :previous_amount_of_provision, null: false
      t.float :new_amount_of_provision, null: false
      t.references :loan, null: false
      t.references :institution_provision
      t.references :repayment_calendar, null: false
      t.references :creation_user, foreign_key: { to_table: :users }, null: false
      t.datetime :deleted_at
      t.timestamps
    end
  end
end
