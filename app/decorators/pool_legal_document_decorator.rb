class PoolLegalDocumentDecorator < ApplicationDecorator
  decorates PoolLegalDocument

  def updated_at_decorated
    object.updated_at.strftime("%F %T")
  end
end
