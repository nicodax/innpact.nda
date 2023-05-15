module Api
  class ApiController < ActionController::Base
    skip_before_action :verify_authenticity_token
    before_action :set_locale

    def current_user
      super.try(:decorate)
    end

    def set_locale
      I18n.locale = params[:locale]
    end
  end
end
