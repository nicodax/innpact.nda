# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Profile management' do
  include_context 'shared factories'

  describe 'Display the user profile' do
    before { sign_in general_manager }

    it 'is a success' do
      get profile_path

      expect(response).to have_http_status(:ok)
      expect(response).to render_template(:show)
    end
  end

  describe 'Edit user profile' do
    before { sign_in general_manager }

    it 'is a success' do
      get edit_profile_path

      expect(response).to have_http_status(:ok)
      expect(response).to render_template(:edit)
    end
  end

  describe 'Update user profile' do
    before { sign_in general_manager }

    it 'is a success' do
      new_lastname = "#{general_manager.lastname} new"
      expect do
        patch profile_path, params: { user: general_manager.attributes.merge(lastname: new_lastname) }
      end.to change { general_manager.lastname }.to(new_lastname)

      follow_redirect!
      expect(response).to render_template(:show)
    end
  end
end
