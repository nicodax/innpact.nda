# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Institution covenants management' do
  include_context 'shared factories'

  describe '#create' do
    context 'signed in as a general_manager' do
      before { sign_in general_manager }

      context 'success' do
        it 'creates a new covenant' do
          expect do
            make_request(attr: { par30: 20, par30_limit: 30 })
          end.to change { InstitutionCovenant.count }.by(1)

          follow_redirect!
          expect(response).to have_http_status(:ok)
        end
      end

      context 'validation fails' do
        it 'it renders the form' do
          make_request(attr: { par30: 120 })

          expect(response).to have_http_status(:unprocessable_entity)
          expect(response).to render_template(:new)
        end
      end
    end

    def make_request(attr: {})
      params = attributes_for(:institution_covenant, institution: institution).merge!(attr)

      post fund_settings_institution_institution_covenants_path(fund_id: fund.id,
                                                                institution_id: institution.id),
           params: { institution_covenant: params }
    end
  end
end
