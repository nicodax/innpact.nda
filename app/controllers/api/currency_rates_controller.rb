# frozen_string_literal: true

module Api
  class CurrencyRatesController < ApiController
    def index
      current_currency_rates = fund.currencies.order('short_name').includes(:current_currency_rates).inject({}) do |h, currency|
        rate = currency.current_rate
        h[currency.short_name] = rate if rate > 0
        h
      end
      render json: { currency_rates: current_currency_rates }, status: :ok
    end

    def fund
      @fund ||= Fund.find(params[:fund_id])
    end
  end
end
