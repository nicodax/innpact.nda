class DashboardNotificationDecorator < ApplicationDecorator
  decorates DashboardNotification

  def path
    if notification_object_type == "LoanRequest"
      Rails.application.routes.url_helpers.fund_loan_request_path(fund_id: notification_object.fund_id,
                                                                  id: notification_object.id, notification_id: id)
    end
  end

  def title
    I18n.t("dashboard_notifications.#{notification_type}.title")
  end

  def creation_date
    created_at.strftime("%F")
  end

  def text
    if notification_object_type == "LoanRequest"
      fund_name = notification_object.fund.name
      if notification_type == DashboardNotification::CREATED_LOAN_REQUEST_TYPE
        user_name = notification_object.user.full_name
      end
      I18n.t("dashboard_notifications.#{notification_type}.text",
             user_name: user_name,
             loan_request_id: notification_object.innpact_loan_id,
             fund_name: fund_name)
    end
  end
end
