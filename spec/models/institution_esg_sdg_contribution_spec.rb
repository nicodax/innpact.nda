# TODO : TO BE DELETED AFTER REFACTORING

# # frozen_string_literal: true

# require 'rails_helper'

# RSpec.describe InstitutionEsgSdgContribution, type: :model do
#   let(:institution) { create(:institution) }

#   describe '#create' do
#     context 'creates a new institution_esg_sdg_contribution' do
#       it 'succeed' do
#         institution_esg_sdg_contribution = institution.institution_esg_sdg_contributions.build(as_of: DateTime.now)
#         institution_esg_sdg_contribution.valid?
#         expect(institution_esg_sdg_contribution).to be_valid
#       end
#     end

#     context 'creates a new institution_esg_sdg_contribution without as_of' do
#       it 'fail' do
#         institution_esg_sdg_contribution = institution.institution_esg_sdg_contributions.build
#         institution_esg_sdg_contribution.valid?
#         expect(institution_esg_sdg_contribution).not_to be_valid
#       end
#     end
#   end
# end
