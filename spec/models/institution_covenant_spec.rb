# frozen_string_literal: true

require 'rails_helper'

RSpec.describe InstitutionCovenant do
  let(:institution) { create(:institution) }
  let(:name) { FFaker::Name }

  describe '#create' do
    context 'success' do
      it 'creates a new covenant' do
        covenant = institution.build_institution_covenant(name: name, par30: 25, par30_limit: 30)
        covenant.valid?
        expect(covenant).to be_valid
      end
    end

    context 'validation fails' do
      it 'fails when the parameters are empty' do
        covenant = institution.build_institution_covenant(name: name)
        covenant.valid?
        expect(covenant).not_to be_valid
        expect(covenant.errors.messages[:covenant]).to eql(["cannot be empty"])
      end

      it 'fails when the parameters have an actual value but not a limit' do
        covenant = institution.build_institution_covenant(name: name, par30: 25)
        covenant.valid?
        expect(covenant.errors.messages[:limit]).to eql(["par30 is missing"])
      end

      it 'fails when the parameters have a limit but not an actual' do
        covenant = institution.build_institution_covenant(name: name, par30_limit: 25)
        covenant.valid?
        expect(covenant.errors.messages[:actual]).to eql(["par30 is missing"])
      end
    end
  end
end
