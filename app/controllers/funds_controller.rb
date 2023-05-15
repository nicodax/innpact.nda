# frozen_string_literal: true

class FundsController < ApplicationController
  before_action :set_fund, only: %i[edit update show archive enable destroy]

  def index
    @funds = policy_scope(Fund.all, policy_scope_class: FundPolicy::Scope)
    @investment_managers = User.for_fund(@funds.pluck(:id)).group_by(&:fund_id)

    if current_user.administrator?
      @archived_funds_count = Fund.inactive.count
      @deleted_funds_count = Fund.only_deleted.count
    end

    # If there's only one fund
    # Display the fund selection page if user has administrator role
    # Else redirect directly to the fund page
    if funds.count == 1
      redirect_to fund_path(fund_id: funds.first.id) unless current_user.administrator?
    end
  end

  def show
    authorize(fund)

    @investment_managers = User.for_fund(fund.id)
    @general_managers = User.with_role(User::ROLE_GENERAL_MANAGER)
    @administrators = User.with_role(User::ROLE_ADMINISTRATOR)
    @institutions = policy_scope(fund.institutions.order('name'))
    @readers = fund.users
  end

  def new
    @fund = Fund.new
    fund.fund_usd_amounts.build
  end

  def edit
    authorize(fund)
  end

  def create
    @fund = Fund.new(fund_params.merge(status: :active))
    authorize(fund)
    if fund.save
      redirect_to root_path, notice: 'Succesfully created Fund'
    else
      flash.now[:alert] = 'Couldn\'t create Fund'
      render :new
    end
  end

  def update
    if fund.update_attributes(fund_params)
      redirect_to fund_path(id: fund.id)
    else
      flash.now[:alert] = 'Couldn\'t update Fund'
      render :edit
    end
  end

  def archive
    authorize(fund)
    if fund.inactive!
      redirect_to funds_path
    else
      redirect_to fund_path(id: fund.id)
    end
  end

  def enable
    authorize(fund)
    if fund.active!
      redirect_to funds_path
    else
      redirect_to fund_path(id: fund.id)
    end
  end

  def destroy
    authorize(fund)

    if fund.destroy
      redirect_to root_path, notice: 'Fund succesfully deleted'
    else
      redirect_to fund_path(id: fund.id), alert: 'Couldn\'t delete fund'
    end
  end

  private

  attr_reader :fund, :funds, :archived_funds_count, :deleted_funds_count, :users, :new_loan

  helper_method :fund, :funds, :archived_funds_count, :deleted_funds_count, :users, :new_loan

  def fund_params
    params.require(:fund).permit(:name, :status, :details, :created_by, user_ids: [])
  end

  def set_fund
    if Fund.only_deleted.where(id: params[:id] || params[:fund_id]).any?
      redirect_to root_path, alert: I18n.t('funds.errors.deleted_fund') and return
    end

    @fund = Fund.find(params[:id] || params[:fund_id]).decorate
  end

end
