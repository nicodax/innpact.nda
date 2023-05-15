require 'json'

class LoanDashboardDecorator < ApplicationDecorator
  decorates Fund

  def deleted_loans_count
    LoanPolicy::Scope.new(h.current_user, loans.only_deleted).resolve.size
  end

  def deleted_loans_policy
    DeletedLoanPolicy.new(h.current_user, Loan)
  end

  def im_groups
    fund.im_groups.pluck(:name, :id)
  end

  def institutions
    fund.institutions.pluck(:name, :id)
  end

  def institution_groups
    fund.institution_groups.pluck(:name, :id)
  end

  def countries
    fund.countries.order(:name).pluck(:name, :id)
  end

  def country_groups
    fund.country_groups.order(:name).pluck(:name, :id)
  end

  def currencies
    fund.currencies.order(:short_name).pluck(:short_name, :id)
  end

  def loan_types
    fund.loan_types.order(:name).pluck(:name, :id)
  end

  def institution_types
    fund.institution_types.order(:name).pluck(:name, :id)
  end

  def bonds
    fund.bonds.order(:name).pluck(:name, :id)
  end

  def interest_rate_types
    fund.interest_rate_types.order(:name).pluck(:name, :id)
  end

  def repayment_types
    fund.repayment_types.order(:name).pluck(:name, :id)
  end

  def pools
    fund.pools.order(:name).pluck(:name, :id)
  end

  def loan_category
    context[:loan_category]
  end

  def initial_params
    @initial_params ||= context[:initial_params].to_h
  end

  def export_params
    JSON.generate(initial_params)
  end

  def search_params
    global_params.merge(initial_params.except(:page))
  end

  def global_params
    {
      user: h.current_user,
      fund: fund,
      loan_category: loan_category
    }
  end

  def page
    initial_params[:page] || 1
  end

  def statuses
    case loan_category
    when :loan_request
      LoanVersion::LOAN_REQUEST_STATUSES.map { |s| [I18n.t("activerecord.attributes.loan.statuses.#{s}"), s] }
    when :accepted
      LoanVersion::ACCEPTED_STATUSES.map { |s| [I18n.t("activerecord.attributes.loan.statuses.#{s}"), s] }
    else
      [[I18n.t("activerecord.attributes.loan.statuses.assigned"), LoanVersion::STATUS_ASSIGNED]]
    end
  end

  def dashboard_loans
    LoanDecorator.decorate_collection(paginated_loans)
  end

  def loan_search
    LoanSearch.new(search_params)
  end

  def loans_count
    search_loans.count
  end

  def paginated_loans
    search_loans.page(page).per(pagination_size)
  end

  def search_loans
    @search_loans ||= loan_search.loans
  end

  def pagination_size
    20
  end
end
