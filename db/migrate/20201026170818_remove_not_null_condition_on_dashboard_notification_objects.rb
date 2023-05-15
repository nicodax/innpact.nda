class RemoveNotNullConditionOnDashboardNotificationObjects < ActiveRecord::Migration[6.0]
  def change
    change_column :dashboard_notifications, :notification_object_id, :integer, null: true
    change_column :dashboard_notifications, :notification_object_type, :string, null: true
  end
end
