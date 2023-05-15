module Settings
  class DeletedUsersController < ApplicationController
    before_action :set_user, only: [:show, :destroy, :restore]

    def index
      @deleted_users = User.only_deleted
      authorize(@deleted_users)
    end

    def show
    end

    def destroy
      if @user.really_destroy!
        redirect_to settings_deleted_users_path, notice: "Succesfully deleted user"
      else
        redirect_to settings_deleted_user_path(id: @user.id)
      end
    end

    def restore
      # if @user.update_attribute(:deleted_at, nil)
      if @user.restore(:recursive => true)
        redirect_to settings_users_path
      else
        redirect_to settings_deleted_user_path(id: @user.id)
      end
    end

    private

    def set_user
      @user = User.with_deleted.find(params[:id])
      authorize(@user)
    end
  end
end
