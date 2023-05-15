# frozen_string_literal: true

class PoolDocument < ApplicationRecord
  include HasSlug

  acts_as_paranoid
  mount_uploader :document, PoolDocumentUploader

  belongs_to :pool
  validates :document, presence: { message: I18n.t('activerecord.models.pool_document.upload_document') }
  validates :original_filename, length: { maximum: 100 }

  def get_parent_of_document
    Pool.with_deleted.find(pool_id)
  end

  def deleted_parent
    Pool.only_deleted.where(id: pool_id).first
  end
end
