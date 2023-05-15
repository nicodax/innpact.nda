# frozen_string_literal: true

class PoolDocumentPolicy < SettingPolicy
  def preview?
    show?
  end
end
