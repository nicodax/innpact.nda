class PoolDecorator < ApplicationDecorator
  decorates Pool
  decorates_association :pool_targets
  # decorates_association :pool_documents

  def previous_targets
    pool_targets.order(created_at: :desc).drop(1)
  end

  def current_target
    object.current_target.decorate if object.current_target
  end

  def pool_documents_by_name
    pool_documents.select(&:persisted?).sort_by { |pd| pd.updated_at }.reverse.group_by { |pd| pd.original_filename }
  end

  def pool_documents_desc
    pool_documents.order(created_at: :desc)
  end

  def pool_legal_documents_desc
    pool_legal_documents.order(created_at: :desc)
  end
end
