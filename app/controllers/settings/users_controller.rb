# frozen_string_literal: true

module Settings
  class UsersController < ApplicationController
    before_action :set_user, only: %i[edit update destroy show]
    before_action :set_user_collection

    def index
      authorize(User)
      @users = User.all.includes(:roles)
      @new_user = User.new
      @deleted_users_count = User.only_deleted.count
    end

    def show
      @funds = Fund.for_user(@user.id)
    end

    def edit
    end

    def create
      @new_user = User.new(user_params)
      authorize(@new_user)
      @new_user.add_role(params[:user][:role].to_sym)
      @new_user.valid?
      @new_user.errors.messages.except!(:password) # remove password from errors

      if @new_user.errors.any?
        @users = User.all.includes(:roles)
        @deleted_users_count = User.only_deleted.count
        flash.now[:alert] = "Couldn't create user"
        render :index
      else
        @new_user.invite!
        redirect_to settings_users_path,
                    notice: t('settings_crud.setting_success_creation', setting_name: t('activerecord.models.user.one'))
      end
    end

    def update
      context = UpdateUserInteractor.call(params: user_params, user: user, current_user: current_user, role: params[:user][:role].to_sym)
      if context.success?
        redirect_to settings_user_path(id: user)
      else
        flash.now[:alert] = context.error_message
        render :edit
      end
    end

    def destroy
      if user.destroy
        redirect_to settings_users_path, notice: t('settings_crud.setting_success_delete_user')
      else
        flash.now[:alert] =
          "#{t('settings_crud.setting_error_delete',
               setting_name: I18n.t("activerecord.models.user.one"))} : #{user.errors.full_messages.join(',')}"
        render :edit
      end
    end

    private

    attr_reader :user, :users

    helper_method :user, :users

    def user_params
      params.require(:user).permit(:email, :firstname, :lastname, :phone_number)
    end

    def set_user
      @user = User.includes(:im_groups).find(params[:id])
      authorize(@user)
    end

    def set_user_collection
      @users = User.all
    end
  end
end
