# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CreateInstitutionInteractor do
  include_context 'shared factories'

  context 'validation with success' do
    let(:setting) { build(:institution, fund: fund) }

    it 'creates a institution' do
      params = attributes_for(:institution, im_group: default_im_group, country: country,
                                            institution_group: institution_group,
                                            institution_type: institution_type)
      context = CreateInstitutionInteractor.call(institution_params: params, fund: fund, setting: setting)

      expect(context).to be_success
    end
  end

  context 'validation failed' do
    let(:setting) { build(:institution, fund: fund) }

    it 'returns validation errors' do
      params = attributes_for(:institution).merge(name: nil)
      context = CreateInstitutionInteractor.call(institution_params: params, fund: fund, setting: setting)

      expect(context).not_to be_success
      expect(context.setting.errors).not_to be_empty
    end
  end
end
