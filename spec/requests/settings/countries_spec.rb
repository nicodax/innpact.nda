# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Fund countries management' do
  include_context 'shared factories'

  let(:country) { create(:country, fund: fund) }

  describe '#index' do
    context 'signed as manager' do
      before { sign_in general_manager }

      it 'is a success' do
        get fund_settings_countries_path(fund_id: fund.id)

        expect(response).to have_http_status(:ok)
        expect(response).to render_template(:index)
      end
    end
  end

  describe '#new' do
    context 'signed as manager' do
      before { sign_in general_manager }

      it 'is a success' do
        get new_fund_settings_country_path(fund_id: fund.id)

        expect(response).to have_http_status(:ok)
        expect(response).to render_template(:new)
        expect(assigns[:new_setting].persisted?).to be_falsey
      end
    end
  end

  describe '#edit' do
    context 'signed as manager' do
      before { sign_in general_manager }

      it 'is success' do
        get edit_fund_settings_country_path(fund_id: fund.id, id: country.id)

        expect(response).to have_http_status(:ok)
        expect(response).to render_template(:edit)
        expect(assigns[:setting]&.id).to eq(country.id)
      end
    end
  end

  describe '#create' do
    context 'signed in as manager' do
      before { sign_in general_manager }

      context 'success' do
        it 'creates a new covenant' do
          expect do
            make_request
          end.to change { Country.count }.by(1)

          follow_redirect!
          expect(response).to have_http_status(:ok)
          expect(response).to render_template(:index)
        end
      end

      context 'validation fails' do
        it 'it renders the form' do
          make_request(attr: { name: nil })

          expect(response).to have_http_status(:unprocessable_entity)
          expect(response).to render_template(:new)
          expect(assigns[:new_setting].persisted?).to be_falsey
        end
      end
    end

    def make_request(attr: {})
      params = attributes_for(:country).merge!(attr)

      post fund_settings_countries_path(fund_id: fund.id), params: { country: params }
    end
  end

  describe '#update' do
    context 'signed in as manager' do
      before { sign_in general_manager }

      context 'success' do
        it 'updates a country' do
          updated_name = 'Updated name'
          make_request(attr: country.attributes.merge!({ 'name' => updated_name }))
          country.reload

          follow_redirect!
          expect(country.name).to eq(updated_name)
          expect(response).to have_http_status(:ok)
          expect(response).to render_template(:show)
        end
      end

      context 'validation fails' do
        it 'it renders the form' do
          make_request(attr: country.attributes.merge!({ 'name' => nil }))

          expect(response).to have_http_status(:unprocessable_entity)
          expect(response).to render_template(:edit)
        end
      end
    end

    def make_request(attr: {})
      params = attributes_for(:country).merge!(attr)

      put fund_settings_country_path(fund_id: fund.id, id: country.id), params: { country: params }
    end
  end
end
