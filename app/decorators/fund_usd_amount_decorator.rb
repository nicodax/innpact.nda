class FundUsdAmountDecorator < ApplicationDecorator
  decorates FundUsdAmount

  def created_at
    object.created_at.strftime("%F")
  end
end
