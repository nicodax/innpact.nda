# frozen_string_literal: true

class LoanExportsController < ApplicationController
  include FundScoped

  def create
    loans = LoanDecorator.decorate_collection(search_loans)
    send_data(LoansExporter.new(loans, loan_category).file_data,
              :type => 'text/csv; charset=utf-8; header=present',
              :filename => filename,
              :disposition => :attachment)
  end

  private

  attr_reader :dashboard, :loans, :loan_search

  helper_method :dashboard, :loans, :loan_search

  def search_loans
    LoanSearch.new(search_params).loans
  end

  def search_params
    params.has_key?(:loan_export) ? JSON.parse(permitted_params[:loan_search]).except("page").merge(global_params) : global_params
  end

  def global_params
    {
      user: current_user,
      fund: fund,
      loan_category: loan_category
    }
  end

  def permitted_params
    params.require(:loan_export).permit(:loan_search)
  end

  def filename
    "loan_exports_#{Time.now.to_date.to_s}.csv"
  end

  def loan_category
    params[:loan_category]
  end
end
