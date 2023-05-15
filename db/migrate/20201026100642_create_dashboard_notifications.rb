class CreateDashboardNotifications < ActiveRecord::Migration[6.0]
  def change
    create_table :dashboard_notifications do |t|
      t.references :user, foreign_key: true
      t.string :notification_type, null: false
      t.string :notification_object_type, null: false
      t.integer :notification_object_id, null: false
      t.datetime :checked_at

      t.timestamps
    end
  end
end
