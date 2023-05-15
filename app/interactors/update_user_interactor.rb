# frozen_string_literal: true

class UpdateUserInteractor
  include Interactor

  def call
    User.transaction do
      update_user
    rescue StandardError => e
      context.fail!
    end
  end

  delegate :params, :user, :current_user, :role, to: :context

  private

  def update_user
    user.assign_attributes(params)

    context.fail!(error_message: "Unprocessable Entity") unless current_user.can_give_role?(role)

    user.roles.clear
    user.add_role role

    if user.save
      context.success
    else
      context.fail!(error_message: "Can't update this user")
    end
  end
end
