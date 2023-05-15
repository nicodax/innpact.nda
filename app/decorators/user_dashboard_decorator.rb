class UserDashboardDecorator < ApplicationDecorator
  decorates User

  def archived_funds_count
    Fund.inactive.count
  end

  def deleted_funds_count
    Fund.only_deleted.count
  end

  def notifications
    @notifications ||= DashboardNotificationDecorator
                       .decorate_collection(DashboardNotification
        .for_user(self)
        .unchecked.select { |notification| notification.notification_object.present? })
  end
end
