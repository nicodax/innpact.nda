# frozen_string_literal: true

require 'rails_helper'

RSpec.describe InstitutionEsgGenderEquality do
  let(:institution) { create(:institution) }
  let(:institution_esg_gender_equality) { create(:institution_esg_gender_equality) }
  let(:user) { create(:user) }

  describe '#create' do
    context 'when created with data' do
      it 'creates a new institution_esg_gender_equality' do
        gender_equality_percentage_keys = institution_esg_gender_equality.decorate.percentage_keys
        minimum_gender_equity_parameters = gender_equality_percentage_keys.index_with { rand(100) }
        minimum_gender_equity_parameters[:user_id] = user.id
        minimum_gender_equity_parameters[:as_of] = DateTime.now
        esg_gender_equalities = institution.institution_esg_gender_equalities.build(minimum_gender_equity_parameters)
        esg_gender_equalities.valid?
        expect(esg_gender_equalities).to be_valid
      end
    end

    context 'when created with blank data' do
      it 'Fails to creates a new institution_esg_gender_equality' do
        gender_equity_parameters = {}
        gender_equity_parameters[:user_id] = user.id
        gender_equity_parameters[:as_of] = DateTime.now
        esg_gender_equalities = institution.institution_esg_gender_equalities.build(gender_equity_parameters)
        esg_gender_equalities.valid?
        expect(esg_gender_equalities).to be_invalid
      end
    end
  end
end
