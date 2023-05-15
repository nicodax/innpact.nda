require 'active_support/concern'
module HasLimitExceptions
  extend ActiveSupport::Concern
  included do
    before_destroy :destroy_limit_exceptions

    def destroy_limit_exceptions
      LimitException.where(model: self.class.name.underscore).where(model_id: id).each(&:destroy)
    end
  end
end
