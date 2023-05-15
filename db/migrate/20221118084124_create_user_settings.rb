# frozen_string_literal: true

class CreateUserSettings < ActiveRecord::Migration[6.0]
  def change
    create_table :user_settings do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :loans_crud, null: false, default: true
      t.integer :loans_validation, null: false, default: true
      t.integer :provisions_crud, null: false, default: true
      t.integer :provisions_validation, null: false, default: true
      t.integer :repayments_crud, null: false, default: true
      t.integer :repayments_validation, null: false, default: true

      t.timestamps
    end
  end
end
