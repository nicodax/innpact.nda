# frozen_string_literal: true
# This controller will be used as a base for all the controllers we'll be using
# So any before_action, methods or whatever will be defined in every controller
class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :check_notification
  include Pundit

  rescue_from Pundit::NotAuthorizedError, with: :render_forbidden_user

  def current_user
    @current_user ||= super.tap do |user|
      ::ActiveRecord::Associations::Preloader.new.preload(user, :roles)
    end
  end

  def render_forbidden_user
    flash[:alert] = I18n.t('access.restricted_message_warning')
    redirect_to root_path
  end

  def app_version_number
    file = File.read('config/version.json')
    data_hash = JSON.parse(file)
    data_hash['revision']
  end

  def check_notification
    if params[:notification_id].present?
      DashboardNotification.find(params[:notification_id]).check
    end
  end
  helper_method :app_version_number
end
