# frozen_string_literal: true

class LoanRequestDocument < ApplicationRecord
  include HasSlug

  acts_as_paranoid
  mount_uploader :document, LoanDocumentUploader

  belongs_to :loan_request
  validates :document, presence: { message: I18n.t('activerecord.models.pool_document.upload_document') }
  validates :original_filename, length: { maximum: 100 }

  def get_parent_of_document
    LoanRequest.with_deleted.find(pool_id)
  end

  def deleted_parent
    LoanRequest.only_deleted.where(id: pool_id).first
  end
end
