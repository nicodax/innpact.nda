# TODO : TO BE DELETED AFTER REFACTORING

# # frozen_string_literal: true

# require 'rails_helper'

# RSpec.describe InstitutionEsgSdgContributionDecorator do
#   include_context 'shared factories'

#   let(:institution) { create(:institution) }
#   let(:institution_esg_sdg_contribution) { create(:institution_esg_sdg_contribution, institution: institution) }

#   describe 'boolean_keys' do
#     it 'check all the boolean keys from institution_esg_sdg_contributions table are returned' do
#       institution_esg_sdg_contribution_table_boolean_column_name = described_class.column_names.select do |column_name|
#         described_class.columns_hash[column_name].type == :boolean
#       end
#       institution_esg_sdg_contribution_decorator = described_class.decorate(institution_esg_sdg_contribution)
#       expect(institution_esg_sdg_contribution_decorator.boolean_keys).to match_array institution_esg_sdg_contribution_table_boolean_column_name
#     end
#   end
# end
