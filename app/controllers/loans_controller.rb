# frozen_string_literal: true

class LoansController < ApplicationController
  include FundScoped

  before_action :set_loan, except: %i[new create]
  before_action :set_institution, only: %i[edit update]
  before_action :check_editable, only: %i[edit update]
  before_action :check_editable_matured_status, only: %i[edit update]

  def show
    authorize(loan)
    calculate_draft_provision
  end

  def new
    if params[:institution_id].blank? || params[:institution_id] == 'null'
      redirect_to fund_path(id: fund.id), alert: I18n.t('loans.create.choose_institution_to_create_loan')
    else
      institution = fund.institutions.find(params[:institution_id])
      loan_params = {
        institution: institution,
        institution_mode_at_creation: institution.invested? ? Loan::INVESTED_INSTITUTION_MODE : Loan::NEW_INSTITUTION_MODE
      }

      if current_user.investment_manager?
        loan_params[:im_group] = current_user.im_group_for_fund(fund: fund)
      end

      @loan = fund.loans.new(loan_params).decorate
      authorize(@loan)
      @im_groups = fund.im_groups
    end
  end

  def edit
    authorize(loan)
  end

  def create
    context = CreateLoanInteractor.call(fund: fund, params: permitted_params, user: current_user)
    if context.success?
      redirect_to fund_loan_path(fund_id: fund.id, id: context.loan),
                  notice: I18n.t('action_notice.success_creation',
                                 object_name: I18n.t('activerecord.models.loan.one').capitalize)
    else
      @loan = context.loan.decorate
      @im_groups = fund.im_groups
      flash.now[:alert] = context.error
      render :new
    end
  end

  def update
    loan_status = loan.status
    context = UpdateLoanInteractor.call(loan: loan, params: permitted_params, user: current_user)
    if context.success?
      redirect_to fund_loan_path(fund_id: fund.id, id: loan),
                  notice: I18n.t(update_notice,
                                 object_name: I18n.t('activerecord.models.loan.one').capitalize)
    else
      @loan = context.loan.decorate(context: { last_valid_status: loan_status })
      flash.now[:alert] = context.error
      render :edit
    end
  end

  def destroy
    authorize(loan)

    if loan.destroy
      path = fund_path(fund_id: fund.id)
      options = { notice: I18n.t('loans.destroy.succesful_destroyed') }
    else
      path = fund_loan_path(fund_id: fund.id, id: loan)
      options = { alert: I18n.t('loans.destroy.destroy_error') }
    end

    redirect_to path, options
  end

  private

  attr_reader :loan, :validation

  helper_method :loan, :validation, :current_status_locked?

  def set_loan
    @loan = Loan.find(params[:id]).decorate
  end

  def set_institution
    @institution = Institution.find(loan.institution_id)
  end

  def current_status_locked?
    !current_user.administrator? &&
      loan.status == loan.last_valid_status &&
      Loan.current_statuses_editable_by_ims.exclude?(loan.status)
  end

  def calculate_draft_provision
    drafted_provision = current_user.institution_provisions.temporary.order(created_at: :desc).first
    return if drafted_provision.blank?

    @draft_loan_provision = CalculateProvisionValueForLoan.new
                                                          .call(loan: loan,
                                                                provision_percentage: drafted_provision.percentage)
  end

  def redirect_path(loan_category)
    case loan_category
    when :accepted
      fund_accepted_loan_dashboard_path(fund: fund)
    when :in_waiting_list
      fund_in_waiting_list_loan_dashboard_path(fund: fund)
    else
      fund_loan_request_dashboard_path(fund: fund)
    end
  end

  def update_notice
    if current_user.investment_manager?
      'action_notice.success_update_with_validation_request'
    else
      'action_notice.success_update'
    end
  end

  def check_editable
    redirect_to fund_loan_path(fund_id: fund.id, id: loan), alert: I18n.t('access.restricted_message_warning') if loan.active_loan_version.temporary? && !policy(loan).validate_or_reject?
  end

  def check_editable_matured_status
    redirect_to fund_loan_path(fund_id: fund.id, id: loan), alert: I18n.t('access.restricted_message_warning') if loan.status == LoanVersion::STATUS_MATURED
  end

  def permitted_params
    if params.dig(:loan, :loan_version)&.key?(:presentable)
      timestamp = DateTime.now
      params[:loan][:loan_version][:presentable_at] =
        params.dig(:loan, :loan_version, :presentable) == '1' ? timestamp : nil

      params[:loan][:presentation_compliance_check][:presentable_at] = params[:loan][:loan_version][:presentable_at]
      params[:loan][:loan_sdg_data][:presentable_at]                 = params[:loan][:loan_version][:presentable_at]
      params.dig(:loan, :loan_version).delete(:presentable)
    end

    params.has_key?(:loan) ?
      params.require(:loan)
            .permit(:institution_id, :im_group_id, :innpact_loan_id,
                    presentation_compliance_check: [
                      :proposed_investment_complies_with_mef_guidelines,
                      :investee_microfinance_portfolio_greater_than_two_times_mef_loan,
                      :kyc_check, :aml_risk_rate, :aml_country_risk_assessment,
                      :tax_report_assessment, :presentable_at
                    ],
                    loan_version: [
                      :status, :pool_id, :presentable_at,
                      :proposed_nominal_amount, :proposed_tenor,
                      :proposed_spread, :proposed_upfront_fees, :proposed_fixed_rate, :assignment_date,
                      :deadline_assignment_date, :approval_date, :deadline_approval_date,
                      :expected_disbursement_date, :probabilities, :currency_id, :loan_type_id,
                      :repayment_type_id,
                      :pending_ratification_nominal_amount, :pending_ratification_tenor,
                      :pending_ratification_spread, :pending_ratification_upfront_fees,
                      :pending_ratification_fixed_rate, :pending_ratification_date,
                      :deadline_pending_ratification_date,
                      :ratified_nominal_amount, :ratified_tenor,
                      :ratified_spread, :ratified_upfront_fees, :ratified_fixed_rate,
                      :ratification_date, :deadline_ratification_date,
                      :pending_approval_nominal_amount, :pending_approval_tenor,
                      :pending_approval_spread, :pending_approval_upfront_fees, :pending_approval_fixed_rate,
                      :pending_approval_date, :deadline_pending_approval_date,
                      :approved_nominal_amount, :approved_tenor, :approved_spread,
                      :approved_upfront_fees, :approved_fixed_rate,
                      :approved_change_request_nominal_amount, :approved_change_request_tenor,
                      :approved_change_request_spread, :approved_change_request_upfront_fees,
                      :approved_change_request_fixed_rate, :approval_change_request_date,
                      :deadline_approval_change_request_date,
                      :executed_nominal_amount, :executed_tenor,
                      :executed_upfront_fees, :executed_fixed_rate, :disbursement_date, :maturity_date,
                      :executed_bond_id, :approved_bond_id, :number_of_disbursement_date_updates,
                      :nav_usd, :approved_interest_rate_type_id, :net_position_value,
                      :gross_position_value, :hedge_checkbox,
                      :hedge_comment, :hedge_interest_rate_type_id, :hedge_spread, :loan_interest_rate_type_id, :loan_spread,
                      :pending_ratification_comment,:ratified_comment,:not_ratified_comment,:assignement_expired_comment,:released_before_approval_comment,
                      :pending_approval_comment,:approved_comment,:not_approved_comment,:approval_expired_comment,:approved_change_request_comment,
                      :invested_comment,:released_after_approval_comment, :not_validated_comment, :invested_hedge_fx_rate
                    ],
                    loan_sdg_data: [
                      :no_poverty, :zero_hunger, :good_health_and_wellbeing, :quality_education, :gender_equality, :clean_water_and_sanitation,
                      :affordable_and_clean_energy, :descent_work_and_economic_growth, :industry_innovation_and_infrastructure,
                      :reduced_inequalities, :sustainable_cities_and_conmmunities, :responsible_consumption_and_production, :climate_action,
                      :life_below_water, :life_on_land, :peace_justice_and_strong_institutions, :partnerships_for_the_goals, :presentable_at
                    ],
                    repayment_calendar: [
                      repayment_calendar_lines_attributes: [
                        :id, :repayment_date, :repayment_type, :original_amount, :received_amount, :status, :provision, :_destroy
                      ]
                    ]) : {}
  end
end
