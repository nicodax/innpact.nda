# frozen_string_literal: true

require 'rails_helper'

RSpec.describe InstitutionEsgGenderEqualityDecorator do
  include_context 'shared factories'

  let(:institution) { create(:institution) }
  let(:institution_esg_gender_equality) { create(:institution_esg_gender_equality, institution: institution) }

  describe 'boolean_keys' do
    it 'check all the boolean keys from institution_esg_gender_equality table are returned' do
      institution_esg_gender_equality_table_boolean_column_name = described_class.column_names.select do |column_name|
        described_class.columns_hash[column_name].type == :boolean
      end
      institution_esg_gender_equality_decorator = described_class.decorate(institution_esg_gender_equality)
      expect(institution_esg_gender_equality_decorator.boolean_keys).to match_array institution_esg_gender_equality_table_boolean_column_name
    end
  end

  describe 'percentage_keys' do
    it 'check all the decimal keys from institution_esg_gender_equality table are returned' do
      institution_esg_gender_equality_table_boolean_column_name = described_class.column_names.select do |column_name|
        described_class.columns_hash[column_name].type == :decimal
      end
      institution_esg_gender_equality_decorator = described_class.decorate(institution_esg_gender_equality)
      expect(institution_esg_gender_equality_decorator.percentage_keys).to match_array institution_esg_gender_equality_table_boolean_column_name
    end
  end
end
