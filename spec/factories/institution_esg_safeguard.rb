# frozen_string_literal: true

FactoryBot.define do
  factory :institution_esg_safeguard do
    institution { association :institution }
    user_id { FactoryBot.create(:user).id }
    as_of { DateTime.now }
    compliance_with_fund_exclusion_list { [true, false].sample }
    compliance_with_international_labour_organization_standards { [true, false].sample }
    compliance_with_international_bill_of_human_rights { [true, false].sample }
    compliance_with_guiding_principles_on_business_and_human_rights { [true, false].sample }
    compliance_with_oecd_guidelines_for_multinational_enterprises { [true, false].sample }
    compliance_with_national_standards_and_law { [true, false].sample }
    compliance_with_client_protection_principles { [true, false].sample }
  end
end
