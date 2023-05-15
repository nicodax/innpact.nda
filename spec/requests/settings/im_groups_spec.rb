# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Fund im_groups management' do
  include_context 'shared factories'

  let!(:im_group) { create(:im_group, fund: fund) }

  describe '#index' do
    context 'signed as manager' do
      before { sign_in general_manager }

      it 'is a success' do
        get fund_settings_im_groups_path(fund_id: fund.id)

        expect(response).to have_http_status(:ok)
        expect(response).to render_template(:index)
      end
    end
  end

  describe '#new' do
    context 'signed as manager' do
      before { sign_in general_manager }

      it 'is a success' do
        get new_fund_settings_im_group_path(fund_id: fund.id)

        expect(response).to have_http_status(:ok)
        expect(response).to render_template(:new)
        expect(assigns[:setting].persisted?).to be_falsey
      end
    end
  end

  describe '#edit' do
    context 'signed as manager' do
      before { sign_in general_manager }

      it 'is a success' do
        get edit_fund_settings_im_group_path(fund_id: fund.id, id: im_group.id)

        expect(response).to have_http_status(:ok)
        expect(response).to render_template(:edit)
        expect(assigns[:setting]&.id).to eq(im_group.id)
      end
    end
  end

  describe '#show' do
    context 'signed as manager' do
      before { sign_in general_manager }

      it 'is a success' do
        get fund_settings_im_group_path(fund_id: fund.id, id: im_group.id)

        expect(response).to have_http_status(:ok)
        expect(response).to render_template(:show)
        expect(assigns[:setting]&.id).to eq(im_group.id)
      end
    end
  end

  describe '#create' do
    context 'signed in as manager' do
      before { sign_in general_manager }

      context 'success' do
        it 'creates a new im_group' do
          attrs = { user_ids: [investment_manager.id] }

          expect do
            make_request(attrs: attrs)
          end.to change { ImGroup.count }.by(1)

          follow_redirect!
          expect(response).to have_http_status(:ok)
          expect(response).to render_template(:index)
        end
      end

      context 'validation fails' do
        it 'it renders the form' do
          make_request(attrs: { name: nil })

          expect(response).to have_http_status(:unprocessable_entity)
          expect(response).to render_template(:new)
          expect(assigns[:setting].persisted?).to be_falsey
        end
      end
    end

    def make_request(attrs: {})
      params = attributes_for(:im_group).merge!(attrs)

      post fund_settings_im_groups_path(fund_id: fund.id), params: { im_group: params }
    end
  end

  describe '#update' do
    context 'signed in as manager' do
      before { sign_in general_manager }

      context 'success' do
        it 'updates a im_group' do
          attrs = { user_ids: [second_investment_manager.id] }

          make_request(attrs: attrs)

          follow_redirect!
          expect(response).to have_http_status(:ok)
          expect(response).to render_template(:show)
          expect(im_group.user_ids).to include(second_investment_manager.id)
        end
      end

      context 'validation fails' do
        it 'it renders the form' do
          make_request(attrs: { name: nil })

          expect(response).to have_http_status(:unprocessable_entity)
          expect(response).to render_template(:edit)
        end
      end
    end

    def make_request(attrs: {})
      params = attributes_for(:im_group).merge!(attrs)

      patch fund_settings_im_group_path(fund_id: fund.id, id: im_group.id), params: { im_group: params }
    end
  end

  describe '#destroy' do
    context 'signed as manager' do
      before { sign_in general_manager }

      context 'valid im_group' do
        let!(:im_group) { create(:im_group, fund: fund) }

        it 'is a success' do
          delete fund_settings_im_group_path(fund_id: fund.id, id: im_group.id)

          expect(response).to redirect_to(fund_settings_im_groups_path(fund_id: fund.id))
          follow_redirect!
          expect(response).to render_template(:index)
        end
      end

      context 'im_group not exists' do
        it 'is a success' do
          delete fund_settings_im_group_path(fund_id: fund.id, id: 443)

          expect(response).to redirect_to(fund_settings_im_groups_path(fund_id: fund.id))
          follow_redirect!
          expect(response).to render_template(:index)
        end
      end
    end
  end
end
