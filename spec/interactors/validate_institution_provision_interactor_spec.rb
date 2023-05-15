# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ValidateInstitutionProvisionInteractor do
  include_context 'shared factories'

  describe 'call' do
    context 'aprove provision proposal' do
      let!(:institution_provision) do
        create(:institution_provision, institution: institution,
                                       version_status: InstitutionProvision::VERSION_STATUS_TEMPORARY)
      end

      it 'updates the institution provision version_status' do
        context = ValidateInstitutionProvisionInteractor.call(validated: 'true',
                                                              user: general_manager,
                                                              institution_provision: institution_provision)

        expect(context.success?).to eq(true)
        expect(context.institution_provision.version_status).to eq(InstitutionProvision::VERSION_STATUS_VALIDATED)
      end
    end

    context 'reject provision proposal' do
      let!(:institution_provision) do
        create(:institution_provision, institution: institution,
                                       version_status: InstitutionProvision::VERSION_STATUS_TEMPORARY)
      end

      it 'updates the institution provision version_status' do
        context = ValidateInstitutionProvisionInteractor.call(validated: 'false',
                                                              user: general_manager,
                                                              institution_provision: institution_provision)
        provision = context.institution_provision

        expect(context.success?).to eq(true)
        expect(provision.version_status).to eq(InstitutionProvision::VERSION_STATUS_REJECTED)
        expect(provision.percentage).to eq(provision.previous_percentage_of_provision)
        expect(provision.new_percentage_of_provision).to eq(provision.previous_percentage_of_provision)
      end
    end

    context 'already validated provision' do
      let!(:institution_provision) do
        create(:institution_provision, institution: institution,
                                       version_status: InstitutionProvision::VERSION_STATUS_REJECTED)
      end

      it 'skips updates for the institution provision' do
        context = ValidateInstitutionProvisionInteractor.call(validated: 'true',
                                                              user: general_manager,
                                                              institution_provision: institution_provision)

        expect(context.success?).to eq(false)
        expect(context.institution_provision.version_status).to eq(InstitutionProvision::VERSION_STATUS_REJECTED)
      end
    end
  end
end
