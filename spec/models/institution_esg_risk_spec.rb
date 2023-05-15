# frozen_string_literal: true

require 'rails_helper'

RSpec.describe InstitutionEsgRisk do
  let(:institution) { create(:institution) }
  let(:institution_esg_risk) { create(:institution_esg_risk) }
  let(:user) { create(:user) }

  describe '#create' do
    context 'when created with blank data' do
      it 'fails to create a new institution_esg_risk' do
        risk_parameters = {}
        risk_parameters[:user_id] = user.id
        risk_parameters[:as_of] = DateTime.now
        esg_risks = institution.institution_esg_risks.build(risk_parameters)
        esg_risks.valid?
        expect(esg_risks).to be_invalid
      end
    end
  end
end
