class PoolTargetDecorator < ApplicationDecorator
  decorates PoolTarget

  def created_at
    object.created_at.strftime("%F")
  end
end
