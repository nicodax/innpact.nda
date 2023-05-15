# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Institutions::LoansProvisionSummary do
  include_context 'shared factories'

  subject { described_class.new }

  describe '#call' do
    context 'valid institution' do
      before do
        loan = create(:loan, fund: fund, institution: institution, creation_user: general_manager,
                             im_group: default_im_group)
        create(:loan_version, :ratified, loan: loan, gross_position_value: 1000, provision_value: 200,
                                         net_position_value: 800, creation_user: general_manager,
                                         currency: currency_usd)

        2.times do |t|
          counter = t + 1
          gross_position_value = counter * 100
          provision_value = counter * 20
          net_position_value = gross_position_value - provision_value

          loan = create(:loan, fund: fund, institution: institution, creation_user: general_manager,
                               im_group: default_im_group)
          create(:loan_version, :invested, loan: loan, gross_position_value: gross_position_value,
                                           creation_user: general_manager, provision_value: provision_value,
                                           currency: currency_usd, net_position_value: net_position_value)
        end
      end

      it 'calculates loans provision summary for invested loans' do
        result = subject.call(institution: institution)

        expect(result.keys).to match_array(%i[gross_exposure provision_amount net_amount])
        expect(result[:gross_exposure]).to eq(300)
        expect(result[:provision_amount]).to eq(60)
        expect(result[:net_amount]).to eq(240)
      end
    end

    context 'empty institution' do
      it 'raises the exception' do
        expect { subject.call(institution: nil) }.to raise_error(Institutions::EmptyInstitution)
      end
    end
  end
end
