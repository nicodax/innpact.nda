# frozen_string_literal: true

class ProfilesController < ApplicationController
  def show
    @role = current_user.roles.first
    @im_groups = current_user.im_groups
    @funds = Fund.for_user(current_user.id)
  end

  def edit; end

  def update
    if current_user.update(user_params)
      redirect_to profile_path, notice: 'Profile updated successfully'
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :firstname, :lastname, :phone_number,
                                 user_setting_attributes: %i[
                                   id
                                   loans_crud
                                   loans_validation
                                   provisions_crud
                                   provisions_validation
                                   repayments_crud
                                   repayments_validation
                                 ])
  end
end
