# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UpdateInstitutionInteractor do
  include_context 'shared factories'

  context 'validation with success' do
    let(:new_name) { 'New name' }

    it 'creates a institution' do
      params = { name: new_name }
      context = UpdateInstitutionInteractor.call(institution_params: params, fund: fund, institution: institution)

      expect(context).to be_success
      institution.reload
      expect(institution.name).to eq(new_name)
    end
  end

  context 'validation failed' do
    it 'returns validation errors' do
      params = { name: nil }
      context = UpdateInstitutionInteractor.call(institution_params: params, fund: fund, institution: institution)

      expect(context).not_to be_success
      expect(context.institution.errors).not_to be_empty
    end
  end
end
