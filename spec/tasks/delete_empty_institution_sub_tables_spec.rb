# frozen_string_literal: true

require 'rails_helper'

Rails.application.load_tasks

RSpec.describe 'delete_empty_institution_sub_tables:delete' do # rubocop:disable RSpec/DescribeClass
  include_context 'shared factories'

  context 'When there is empty values in institution sub_tables' do
    let!(:institution) { create(:institution) }
    let!(:user) { create(:user) }
    let!(:institution_esg_risks_not_empty1) do
      InstitutionEsgRisk.create!(
        as_of: DateTime.now,
        institution_id: institution.id,
        user_id: user.id,
        tool_use_for_esg_score: 'test'
      )
    end
    let!(:institution_esg_risks_not_empty2) do
      InstitutionEsgRisk.create!(
        as_of: DateTime.now,
        institution_id: institution.id,
        user_id: user.id,
        esms_in_place_commensurate_with_risk_profile: true
      )
    end
    let!(:institution_esg_risks_not_empty3) do
      InstitutionEsgRisk.create!(
        as_of: DateTime.now,
        institution_id: institution.id,
        user_id: user.id,
        internal_esg_score: 'test'
      )
    end
    let!(:institution_esg_pai_indicator) { create(:institution_esg_pai_indicator) }
    let!(:institution_rating) { create(:institution_rating) }
    let!(:institution_financial) { create(:institution_financial) }
    let!(:institution_specific_breakdown) { create(:institution_specific_breakdown) }
    let!(:institution_impact_indicator) { create(:institution_impact_indicator) }
    let!(:positive_impact_services_offered) { create(:positive_impact_services_offered) }
    let!(:institution_esg_gender_equality) { create(:institution_esg_gender_equality) }
    let!(:institution_alinus_result) { create(:institution_alinus_result) }
    let!(:institution_esg_safeguard) { create(:institution_esg_safeguard) }
    let!(:additional_pais_environment) { create(:additional_pais_environment) }
    let!(:additional_pais_social) { create(:additional_pais_social) }

    it 'validates that all the non empty institution_esg_risks are not deleted' do
      expect(InstitutionEsgRisk.all).to include(
        institution_esg_risks_not_empty1,
        institution_esg_risks_not_empty2,
        institution_esg_risks_not_empty3
      )
      Rake::Task['delete_empty_institution_sub_tables:delete'].execute
      expect(InstitutionEsgRisk.all).to include(
        institution_esg_risks_not_empty1,
        institution_esg_risks_not_empty2,
        institution_esg_risks_not_empty3
      )
    end

    it 'validates that the non empty institution institution_esg_pai_indicators is not deleted' do
      expect(InstitutionEsgPaiIndicator.all).to include(institution_esg_pai_indicator)
      Rake::Task['delete_empty_institution_sub_tables:delete'].execute
      expect(InstitutionEsgPaiIndicator.all).to include(institution_esg_pai_indicator)
    end

    it 'validates that the non empty institution institution_rating is not deleted' do
      expect(InstitutionRating.all).to include(institution_rating)
      Rake::Task['delete_empty_institution_sub_tables:delete'].execute
      expect(InstitutionRating.all).to include(institution_rating)
    end

    it 'validates that the non empty institution institution_financial is not deleted' do
      expect(InstitutionFinancial.all).to include(institution_financial)
      Rake::Task['delete_empty_institution_sub_tables:delete'].execute
      expect(InstitutionFinancial.all).to include(institution_financial)
    end

    it 'validates that the non empty institution institution_specific_breakdown is not deleted' do
      expect(InstitutionSpecificBreakdown.all).to include(institution_specific_breakdown)
      Rake::Task['delete_empty_institution_sub_tables:delete'].execute
      expect(InstitutionSpecificBreakdown.all).to include(institution_specific_breakdown)
    end

    it 'validates that the non empty institution institution_impact_indicator is not deleted' do
      expect(InstitutionImpactIndicator.all).to include(institution_impact_indicator)
      Rake::Task['delete_empty_institution_sub_tables:delete'].execute
      expect(InstitutionImpactIndicator.all).to include(institution_impact_indicator)
    end

    it 'validates that the non empty institution positive_impact_services_offered is not deleted' do
      expect(PositiveImpactServicesOffered.all).to include(positive_impact_services_offered)
      Rake::Task['delete_empty_institution_sub_tables:delete'].execute
      expect(PositiveImpactServicesOffered.all).to include(positive_impact_services_offered)
    end

    it 'validates that the non empty institution institution_esg_gender_equality is not deleted' do
      expect(InstitutionEsgGenderEquality.all).to include(institution_esg_gender_equality)
      Rake::Task['delete_empty_institution_sub_tables:delete'].execute
      expect(InstitutionEsgGenderEquality.all).to include(institution_esg_gender_equality)
    end

    it 'validates that the non empty institution institution_alinus_result is not deleted' do
      expect(InstitutionAlinusResult.all).to include(institution_alinus_result)
      Rake::Task['delete_empty_institution_sub_tables:delete'].execute
      expect(InstitutionAlinusResult.all).to include(institution_alinus_result)
    end

    it 'validates that the non empty institution institution_esg_safeguard is not deleted' do
      expect(InstitutionEsgSafeguard.all).to include(institution_esg_safeguard)
      Rake::Task['delete_empty_institution_sub_tables:delete'].execute
      expect(InstitutionEsgSafeguard.all).to include(institution_esg_safeguard)
    end

    it 'validates that the non empty institution additional_pais_environment is not deleted' do
      expect(AdditionalPaisEnvironment.all).to include(additional_pais_environment)
      Rake::Task['delete_empty_institution_sub_tables:delete'].execute
      expect(AdditionalPaisEnvironment.all).to include(additional_pais_environment)
    end

    it 'validates that the non empty institution additional_pais_social is not deleted' do
      expect(AdditionalPaisSocial.all).to include(additional_pais_social)
      Rake::Task['delete_empty_institution_sub_tables:delete'].execute
      expect(AdditionalPaisSocial.all).to include(additional_pais_social)
    end
  end
end
