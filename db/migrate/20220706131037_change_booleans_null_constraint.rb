class ChangeBooleansNullConstraint < ActiveRecord::Migration[6.0]
  def change
    change_column_null :institution_esg_gender_equalities, :financial_services_targeting_women, :true
    change_column_null :institution_esg_gender_equalities, :non_financial_services_targeting_women, :true
    change_column_null :institution_esg_gender_equalities, :training_on_responsible_finance_targeting_women, :true
    change_column_null :institution_esg_risks, :esms_in_place_commensurate_with_risk_profile, :true
    change_column_null :institution_esg_safeguards, :compliance_with_fund_exclusion_list, :true
    change_column_null :institution_esg_safeguards, :compliance_with_international_labour_organization_standards, :true
    change_column_null :institution_esg_safeguards, :compliance_with_international_bill_of_human_rights, :true
    change_column_null :institution_esg_safeguards, :compliance_with_guiding_principles_on_business_and_human_rights, :true
    change_column_null :institution_esg_safeguards, :compliance_with_oecd_guidelines_for_multinational_enterprises, :true
    change_column_null :institution_esg_safeguards, :compliance_with_national_standards_and_law, :true
    change_column_null :institution_esg_safeguards, :compliance_with_client_protection_principles, :true

    change_column_default :institution_esg_gender_equalities, :financial_services_targeting_women, nil
    change_column_default :institution_esg_gender_equalities, :non_financial_services_targeting_women, nil
    change_column_default :institution_esg_gender_equalities, :training_on_responsible_finance_targeting_women, nil
    change_column_default :institution_esg_risks, :esms_in_place_commensurate_with_risk_profile, nil
    change_column_default :institution_esg_safeguards, :compliance_with_fund_exclusion_list, nil
    change_column_default :institution_esg_safeguards, :compliance_with_international_labour_organization_standards, nil
    change_column_default :institution_esg_safeguards, :compliance_with_international_bill_of_human_rights, nil
    change_column_default :institution_esg_safeguards, :compliance_with_guiding_principles_on_business_and_human_rights, nil
    change_column_default :institution_esg_safeguards, :compliance_with_oecd_guidelines_for_multinational_enterprises, nil
    change_column_default :institution_esg_safeguards, :compliance_with_national_standards_and_law, nil
    change_column_default :institution_esg_safeguards, :compliance_with_client_protection_principles, nil
  end
end
