# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PresentationComplianceCheck do
  describe 'when data is missing' do
    subject(:empty) { described_class.create(loan: create(:loan)) }

    it { is_expected.to be_valid }
  end
end
