# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Fund deleted items management' do
  include_context 'shared factories'

  describe '#index' do
    context 'signed as an admin' do
      before { sign_in administrator }

      it 'is a success' do
        get fund_settings_recycle_bin_path(fund_id: fund.id)

        expect(response).to have_http_status(:ok)
        expect(response).to render_template(:index)
      end
    end

    context 'signed as a general manager' do
      before { sign_in general_manager }

      it 'is a success' do
        get fund_settings_recycle_bin_path(fund_id: fund.id)

        expect(response).to have_http_status(:ok)
        expect(response).to render_template(:index)
      end
    end

    context 'signed as an investment manager' do
      before { sign_in investment_manager }

      it 'redirects with authorization error message' do
        get fund_settings_recycle_bin_path(fund_id: fund.id)

        expect(response).to redirect_to(root_url)
        follow_redirect!

        expect(response.body).to include('You are not authorized to access this page.')
      end
    end

    context 'signed as a reader' do
      before { sign_in reader }

      it 'redirects with authorization error message' do
        get fund_settings_recycle_bin_path(fund_id: fund.id)

        expect(response).to redirect_to(root_url)
        follow_redirect!

        expect(response.body).to include('You are not authorized to access this page.')
      end
    end
  end

  describe '#restore' do
    context 'signed as an admin' do
      let!(:country) { create(:country, fund: fund, deleted_at: Time.current) }
      before { sign_in administrator }

      it 'is a success' do
        put fund_settings_restore_deleted_item_path(fund_id: fund.id, record_type: 'country', record_id: country.id)
        expect(response).to redirect_to(fund_settings_recycle_bin_path(fund_id: fund.id))
        follow_redirect!

        expect(response.body).to_not include(country.name)
      end
    end

    context 'signed as a general manager' do
      let!(:country) { create(:country, fund: fund, deleted_at: Time.current) }
      before { sign_in general_manager }

      it 'is a success' do
        put fund_settings_restore_deleted_item_path(fund_id: fund.id, record_type: 'country', record_id: country.id)
        expect(response).to redirect_to(fund_settings_recycle_bin_path(fund_id: fund.id))
        follow_redirect!

        expect(response.body).to_not include(country.name)
      end
    end

    context 'signed as an investment manager' do
      let!(:country) { create(:country, fund: fund, deleted_at: Time.current) }
      before { sign_in investment_manager }

      it 'redirects with authorization error message' do
        put fund_settings_restore_deleted_item_path(fund_id: fund.id, record_type: 'country', record_id: country.id)

        expect(response).to redirect_to(root_url)
        follow_redirect!

        expect(response.body).to include('You are not authorized to access this page.')
      end
    end

    context 'signed as a reader' do
      let!(:country) { create(:country, fund: fund, deleted_at: Time.current) }
      before { sign_in reader }

      it 'redirects with authorization error message' do
        put fund_settings_restore_deleted_item_path(fund_id: fund.id, record_type: 'country', record_id: country.id)

        expect(response).to redirect_to(root_url)
        follow_redirect!

        expect(response.body).to include('You are not authorized to access this page.')
      end
    end
  end

  describe '#destroy' do
    context 'signed as an admin' do
      let!(:country) { create(:country, fund: fund, deleted_at: Time.current) }
      before { sign_in administrator }

      it 'is a success' do
        delete fund_settings_restore_deleted_item_path(fund_id: fund.id, record_type: 'country', record_id: country.id)
        expect(response).to redirect_to(fund_settings_recycle_bin_path(fund_id: fund.id))
        follow_redirect!

        expect(response.body).to_not include(country.name)
      end
    end

    context 'signed as a general manager' do
      let!(:country) { create(:country, fund: fund, deleted_at: Time.current) }
      before { sign_in general_manager }

      it 'is a success' do
        delete fund_settings_restore_deleted_item_path(fund_id: fund.id, record_type: 'country', record_id: country.id)
        expect(response).to redirect_to(fund_settings_recycle_bin_path(fund_id: fund.id))
        follow_redirect!

        expect(response.body).to_not include(country.name)
      end
    end

    context 'signed as an investment manager' do
      let!(:country) { create(:country, fund: fund, deleted_at: Time.current) }
      before { sign_in investment_manager }

      it 'redirects with authorization error message' do
        delete fund_settings_restore_deleted_item_path(fund_id: fund.id, record_type: 'country', record_id: country.id)

        expect(response).to redirect_to(root_url)
        follow_redirect!

        expect(response.body).to include('You are not authorized to access this page.')
      end
    end

    context 'signed as a reader' do
      let!(:country) { create(:country, fund: fund, deleted_at: Time.current) }
      before { sign_in reader }

      it 'redirects with authorization error message' do
        delete fund_settings_restore_deleted_item_path(fund_id: fund.id, record_type: 'country', record_id: country.id)

        expect(response).to redirect_to(root_url)
        follow_redirect!

        expect(response.body).to include('You are not authorized to access this page.')
      end
    end
  end
end
