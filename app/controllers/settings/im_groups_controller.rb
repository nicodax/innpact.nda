# frozen_string_literal: true

module Settings
  class ImGroupsController < SettingsController
    include FundScoped

    skip_before_action :set_setting_collection
    skip_before_action :set_setting

    def index
      authorize(ImGroup)
      @im_groups = fund.im_groups
    end

    def show
      authorize(ImGroup)
      @im_groups = fund.im_groups
      @setting = @im_groups.includes(:users).find(params[:id])
    end

    def new
      authorize(ImGroup)
      @im_groups = fund.im_groups
      @setting = @im_groups.build
      set_investment_managers
    end

    def edit
      authorize(ImGroup)
      @im_groups = fund.im_groups
      @setting = @im_groups.find(params[:id])
      set_investment_managers
    end

    def create
      authorize(ImGroup)
      @im_groups = fund.im_groups
      @setting = @im_groups.build(setting_params)

      if @setting.save
        redirect_to fund_settings_im_groups_path(fund_id: fund.id),
                    notice: t('settings_crud.setting_success_creation', setting_name: resource_name)
      else
        flash.now[:alert] = t('settings_crud.setting_error_creation', setting_name: resource_name.downcase)
        set_investment_managers
        render :new, status: :unprocessable_entity
      end
    end

    def update
      authorize(ImGroup)
      @im_groups = fund.im_groups
      @setting = @im_groups.find(params[:id])

      if @setting.update(setting_params)
        redirect_to fund_settings_im_group_path(fund_id: fund.id, id: @setting.id),
                    notice: t('settings_crud.setting_success_update', setting_name: resource_name)
      else
        flash.now[:alert] = t('settings_crud.setting_error_update', setting_name: resource_name.downcase)
        set_investment_managers
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      authorize(ImGroup)
      @setting = fund.im_groups.find(params[:id])

      if @setting.assigned?
        redirect_to fund_settings_im_groups_path(fund_id: fund.id),
                    alert: t('settings_crud.setting_error_not_allowed') and return
      end

      if @setting.destroy
        flash[:notice] = t('settings_crud.setting_success_destroy', setting_name: resource_name)
      else
        flash[:error] = t('settings_crud.setting_error_delete', setting_name: resource_name)
      end

      redirect_to fund_settings_im_groups_path(fund_id: fund.id)
    end

    private

    def set_investment_managers
      scope = User.with_role(User::ROLE_INVESTMENT_MANAGER)

      @available_managers = scope.where.not(id: fund.members_ids)
      @assigned_managers = scope.where(id: @setting.user_ids)
    end

    def resource_class
      ImGroup
    end

    def setting_params
      params.require(:im_group).permit(:name, :description, user_ids: [])
    end
  end
end
