require 'rails_helper'

RSpec.describe Api::CurrencyRatesController do
  let!(:fund_1) { create(:fund) }
  let!(:currency_eur) { create(:currency, short_name: 'EUR', fund: fund_1) }
  let!(:currency_rate_eur_1) do
    create(:currency_rate, currency: currency_eur, rate: 0.1, expired_date: Date.today - 1.day)
  end
  let!(:currency_rate_eur_2) { create(:currency_rate, currency: currency_eur, rate: 0.2) }
  let!(:currency_yen) { create(:currency, short_name: 'YEN', fund: fund_1) }
  let!(:currency_rate_yen_1) do
    create(:currency_rate, currency: currency_yen, rate: 2.0, expired_date: Date.today - 1.day)
  end
  let!(:currency_rate_yen_2) { create(:currency_rate, currency: currency_yen, rate: 3.0) }
  let!(:fund_2) { create(:fund) }
  let!(:currency_eur_2) { create(:currency, short_name: 'EUR', fund: fund_2) }
  let!(:currency_rate_eur_2_1) do
    create(:currency_rate, currency: currency_eur_2, rate: 0.5, expired_date: Date.today - 1.day)
  end
  let!(:currency_rate_eur_2_2) { create(:currency_rate, currency: currency_eur_2, rate: 0.7) }
  let!(:currency_yen_2) { create(:currency, short_name: 'YEN', fund: fund_2) }
  let!(:currency_rate_yen_2_1) do
    create(:currency_rate, currency: currency_yen_2, rate: 4.0, expired_date: Date.today - 1.day)
  end
  let!(:currency_rate_yen_2_2) { create(:currency_rate, currency: currency_yen_2, rate: 5.0) }

  describe 'get current currency rates' do
    it 'gets current currency rates' do
      get '/api/currency_rates', params: { fund_id: fund_1.id }

      expect(response).to have_http_status(:ok)

      body = response.parsed_body
      currency_rates = body['currency_rates']

      expect(currency_rates['EUR']).to eq('0.2')
      expect(currency_rates['YEN']).to eq('3.0')
    end
  end
end
