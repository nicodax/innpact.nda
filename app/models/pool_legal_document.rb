# frozen_string_literal: true

class PoolLegalDocument < ApplicationRecord
  include HasSlug
  acts_as_paranoid
  mount_uploader :document, PoolLegalDocumentUploader

  belongs_to :pool
  validates :document, presence: { message: I18n.t('activerecord.models.pool_legal_document.upload_document') }
  validates :original_filename, length: { maximum: 100 }

  before_destroy :check_minimal_pool_legal_document_numbers

  def get_parent_of_document
    Pool.with_deleted.find(pool_id)
  end

  def deleted_parent
    Pool.only_deleted.where(id: pool_id).first
  end

  def check_minimal_pool_legal_document_numbers
    if !destroyed_by_association && self.deleted_at.nil?
      if pool.pool_legal_documents.size <= 1
        self.errors.add(:base, I18n.t('settings.pool_legal_documents.destroy.cannot_destroy_last_document'))
        throw :abort
      end
    end
  end
end
