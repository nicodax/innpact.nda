# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Institution provisions management' do
  include_context 'shared factories'

  describe '#validate' do
    let!(:institution_provision) do
      create(:institution_provision, institution: institution,
                                     version_status: InstitutionProvision::VERSION_STATUS_TEMPORARY)
    end

    def make_request(validated:)
      post validate_fund_settings_institution_institution_provision_path(fund_id: fund,
                                                                         institution_id: institution.id,
                                                                         id: institution_provision.id,
                                                                         validated: validated)
    end

    context 'signed in as a general_manager' do
      before do
        sign_in general_manager
        expect(ValidateInstitutionProvisionInteractor).to receive(:call)
          .once.with(validated: validated.to_s,
                     user: general_manager,
                     institution_provision: institution_provision)
          .and_return(context)
      end

      context 'approve provision proposal' do
        let(:validated) { true }
        let(:context) do
          double(:context, success?: true,
                           institution_provision: instance_double('InstitutionProvision', validated?: true))
        end

        it 'redirects to institution provisions view' do
          make_request validated: validated

          expect(response).to redirect_to(fund_settings_institution_path(id: institution,
                                                                         anchor: 'provisions_tab'))
        end

        it 'sets valid flash message' do
          make_request validated: validated

          follow_redirect!
          expect(response.body).to include(I18n.t('settings.institutions.provisions.validation.validated'))
        end
      end

      context 'validation failed' do
        let(:validated) { false }
        let(:context) do
          double(:context, success?: false,
                           institution_provision: instance_double('InstitutionProvision', validated?: false,
                                                                                          rejected?: false))
        end

        it 'redirects to institution provisions view' do
          make_request validated: validated

          expect(response).to redirect_to(fund_settings_institution_path(id: institution,
                                                                         anchor: 'provisions_tab'))
        end

        it 'sets valid flash message' do
          make_request validated: validated

          follow_redirect!
          expect(response.body).to include(I18n.t('settings.institutions.provisions.validation.failed'))
        end
      end

      context 'reject provision proposal' do
        let(:validated) { false }
        let(:context) do
          double(:context, success?: true,
                           institution_provision: instance_double('InstitutionProvision', validated?: false,
                                                                                          rejected?: true))
        end

        it 'redirects to institution provisions view' do
          make_request validated: validated

          expect(response).to redirect_to(fund_settings_institution_path(id: institution,
                                                                         anchor: 'provisions_tab'))
        end

        it 'sets valid flash message' do
          make_request validated: validated

          follow_redirect!
          expect(response.body).to include(I18n.t('settings.institutions.provisions.validation.rejected'))
        end
      end
    end
  end
end
