class AddFundsUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :funds_users do |t|
      t.references :user, null: false, foreign_key: true
      t.references :fund, null: false, foreign_key: true
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
