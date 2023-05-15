# frozen_string_literal: true

class PoolLegalDocumentPolicy < SettingPolicy
  def preview?
    show?
  end
end
