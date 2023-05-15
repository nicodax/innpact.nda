# frozen_string_literal: true

class LoanRequestDocumentsController < ApplicationController
  include FundScoped

  before_action :set_loan_request
  before_action :set_loan_request_document, only: [:show, :edit, :update, :destroy]

  def new
    @loan_request_document = loan_request.loan_request_documents.build
    authorize @loan_request_document
  end

  def create
    generate_loan_request_document
  end

  def update
    if loan_request_document.update_attributes(loan_request_document_params)
      redirect_to fund_loan_request_documents_path,
                  notice: t("action_notice.success_update",
                            object_name: t("activerecord.models.loan_request_document.one"))
    else
      flash.now[:alert] =
        t("action_notice.error_update", object_name: t("activerecord.models.loan_request_document.one"))
      render :edit
    end
  end

  def destroy
    if loan_request_document.destroy
      redirect_to fund_loan_request_documents_path,
                  notice: t("action_notice.success_delete",
                            object_name: t("activerecord.models.loan_request_document.one"))
    else
      flash.now[:alert] =
        t("action_notice.error_delete", object_name: t("activerecord.models.loan_request_document.one"))
      render :edit
    end
  end

  def preview
    set_loan_request_document
    send_data loan_request_document.document.read, filename: loan_request_document.original_filename,
                                                   disposition: :inline
  end

  def resource_class
    LoanRequestDocument
  end

  private

  attr_reader :loan_request, :loan_request_document

  helper_method :loan_request, :loan_request_document, :loan_request_documents

  def set_loan_request
    @loan_request = LoanRequest
                    .find(params[:loan_request_id])
    # .decorate
  end

  def set_loan_request_document
    set_loan_request
    @loan_request_document = loan_request.loan_request_documents.find_by(slug: params[:document_slug] || params[:slug])
    authorize(loan_request_document)
  end

  def loan_request_documents
    @loan_request_documents ||= loan_request.decorate.loan_request_documents_by_name
  end

  def loan_request_document_params
    params.require(:loan_request_document).permit(:document, :original_filename)
  end

  def after_update_path
    fund_loan_request_documents_path(fund_id: loan_request.fund, id: loan_request)
  end

  def generate_loan_request_document
    @loan_request_document = loan_request.loan_request_documents.build(loan_request_document_params)
    authorize loan_request_document
    if loan_request_document.save
      redirect_to after_update_path
    else
      render :new
    end
  end
end
