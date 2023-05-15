# frozen_string_literal: true

require 'rails_helper'

RSpec.describe InstitutionEsgSafeguard do
  let(:institution) { create(:institution) }
  let(:user) { create(:user) }

  describe '#create' do
    context 'when create with all data' do
      it 'succeed' do
        esg_safeguards = institution.institution_esg_safeguards.build(
          user_id: user.id,
          as_of: DateTime.now,
          compliance_with_fund_exclusion_list: true,
          compliance_with_international_labour_organization_standards: true,
          compliance_with_international_bill_of_human_rights: true,
          compliance_with_guiding_principles_on_business_and_human_rights: true,
          compliance_with_oecd_guidelines_for_multinational_enterprises: true,
          compliance_with_national_standards_and_law: true,
          compliance_with_client_protection_principles: true
        )
        esg_safeguards.valid?
        expect(esg_safeguards).to be_valid
      end
    end

    context 'when create without as_of data' do
      it 'fails' do
        esg_safeguards = institution.institution_esg_safeguards.build(user_id: user.id)
        esg_safeguards.valid?
        expect(esg_safeguards).not_to be_valid
      end
    end

    context 'when created with blank data' do
      it 'fails to create a new institution_esg_safeguard' do
        esg_safeguards_parameters = {}
        esg_safeguards_parameters[:user_id] = user.id
        esg_safeguards_parameters[:as_of] = DateTime.now
        esg_safeguards = institution.institution_esg_safeguards.build(esg_safeguards_parameters)
        esg_safeguards.valid?
        expect(esg_safeguards).not_to be_valid
      end
    end
  end
end
