# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AdditionalPaisEnvironment do
  let(:institution) { create(:institution) }

  describe '#create' do
    context 'when all the variables are entered' do
      it 'creates an additional pai environment' do
        environment = AdditionalPaisEnvironment.create(institution_id: institution.id,
                                                       environment_pai_reported: 'E1',
                                                       environment_pai_value: 10,
                                                       as_of: Date.today)
        environment.valid?
        expect(environment).to be_valid
      end
    end

    context 'when as_of is missing' do
      it 'fails to create an additional pai environment' do
        environment = AdditionalPaisEnvironment.create(institution_id: institution.id,
                                                       environment_pai_reported: 'E1',
                                                       environment_pai_value: 10)
        environment.valid?
        expect(environment).to be_invalid
      end
    end

    context 'when environment_pai_value is missing' do
      it 'fails to create an additional pai environment' do
        environment = AdditionalPaisEnvironment.create(institution_id: institution.id,
                                                       environment_pai_reported: 'E1',
                                                       as_of: Date.today)
        environment.valid?
        expect(environment).to be_invalid
      end
    end

    context 'when environment_pai_reported is missing' do
      it 'fails to create an additional pai environment' do
        environment = AdditionalPaisEnvironment.create(institution_id: institution.id,
                                                       environment_pai_value: 10,
                                                       as_of: Date.today)
        environment.valid?
        expect(environment).to be_invalid
      end
    end

    context 'when environment_pai_value is not with correct format' do
      it 'fails to create an additional pai environment when environment_pai_value is nil' do
        environment = AdditionalPaisEnvironment.create(institution_id: institution.id,
                                                       environment_pai_reported: 'E1',
                                                       environment_pai_value: nil,
                                                       as_of: Date.today)
        environment.valid?
        expect(environment).to be_invalid
      end

      it 'fails to create an additional pai environment when environment_pai_value is negative' do
        environment = AdditionalPaisEnvironment.create(institution_id: institution.id,
                                                       environment_pai_reported: 'E11',
                                                       environment_pai_value: -10,
                                                       as_of: Date.today)
        environment.valid?
        expect(environment).to be_invalid
      end

      it 'fails to create an additional pai environment when environment_pai_value is over 100 and environment_pai_reported is %' do
        environment = AdditionalPaisEnvironment.create(institution_id: institution.id,
                                                       environment_pai_reported: 'E11',
                                                       environment_pai_value: 120,
                                                       as_of: Date.today)
        environment.valid?
        expect(environment).to be_invalid
      end
    end
  end
end
