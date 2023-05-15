# frozen_string_literal: true

require 'rails_helper'

RSpec.describe InstitutionEsgPaiIndicator do
  let(:institution) { create(:institution) }
  let(:institution_esg_pai_indicator) { create(:institution_esg_pai_indicator) }
  let(:user) { create(:user) }

  describe '#create' do
    context 'when created with blank data' do
      it 'fails to create a new institution_esg_pai_indicator' do
        pai_indicator_parameters = {}
        pai_indicator_parameters[:user_id] = user.id
        pai_indicator_parameters[:as_of] = DateTime.now
        esg_pai_indicators = institution.institution_esg_pai_indicators.build(pai_indicator_parameters)
        esg_pai_indicators.valid?
        expect(esg_pai_indicators).to be_invalid
      end
    end
  end

  describe 'Test sum_ghg_scope_emissions' do
    context 'when all emissions has value' do
      it 'returns the sum of all 3 emissions' do
        pai_indicator_parameters = {}
        pai_indicator_parameters[:user_id] = user.id
        pai_indicator_parameters[:scope_1_emissions] = 20
        pai_indicator_parameters[:scope_2_emissions] = 12
        pai_indicator_parameters[:scope_3_emissions] = 18
        esg_pai_indicators = institution.institution_esg_pai_indicators.build(pai_indicator_parameters)
        expect(esg_pai_indicators.sum_ghg_scope_emissions).to eq(50.0)
      end
    end

    context 'when created with scope_n_emissions = nil' do
      it 'returns 0 when all emissions are nil' do
        pai_indicator_parameters = {}
        pai_indicator_parameters[:user_id] = user.id
        pai_indicator_parameters[:scope_1_emissions] = nil
        pai_indicator_parameters[:scope_2_emissions] = nil
        pai_indicator_parameters[:scope_3_emissions] = nil
        pai_indicator_parameters[:carbon_footprint] = 0
        esg_pai_indicators = institution.institution_esg_pai_indicators.build(pai_indicator_parameters)
        expect(esg_pai_indicators.sum_ghg_scope_emissions).to be(0.0)
      end

      it 'returns sum of sum_ghg_scope_emissions without nil when some emissions are nil' do
        pai_indicator_parameters = {}
        pai_indicator_parameters[:user_id] = user.id
        pai_indicator_parameters[:scope_1_emissions] = 20
        pai_indicator_parameters[:scope_2_emissions] = nil
        pai_indicator_parameters[:scope_3_emissions] = 20
        esg_pai_indicators = institution.institution_esg_pai_indicators.build(pai_indicator_parameters)
        expect(esg_pai_indicators.sum_ghg_scope_emissions).to eq(40.0)
      end
    end
  end
end
