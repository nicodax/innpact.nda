# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AdditionalPaisSocial do
  let(:institution) { create(:institution) }

  describe '#create' do
    context 'when all the variables are entered' do
      it 'creates an additional pai social' do
        social = AdditionalPaisSocial.create(institution_id: institution.id,
                                             social_pai_reported: 'E1',
                                             social_pai_value: 10,
                                             as_of: Date.today)
        social.valid?
        expect(social).to be_valid
      end
    end

    context 'when as_of is missing' do
      it 'fails to create an additional pai social' do
        social = AdditionalPaisSocial.create(institution_id: institution.id,
                                             social_pai_reported: 'E1',
                                             social_pai_value: 10)
        social.valid?
        expect(social).to be_invalid
      end
    end

    context 'when social_pai_value is missing' do
      it 'fails to create an additional pai social' do
        social = AdditionalPaisSocial.create(institution_id: institution.id,
                                             social_pai_reported: 'E1',
                                             as_of: Date.today)
        social.valid?
        expect(social).to be_invalid
      end
    end

    context 'when social_pai_reported is missing' do
      it 'fails to create an additional pai social' do
        social = AdditionalPaisSocial.create(institution_id: institution.id,
                                             social_pai_value: 10,
                                             as_of: Date.today)
        social.valid?
        expect(social).to be_invalid
      end
    end

    context 'when social_pai_value is not with correct format' do
      it 'fails to create an additional pai social when social_pai_value is nil' do
        social = AdditionalPaisSocial.create(institution_id: institution.id,
                                             social_pai_reported: 'E1',
                                             social_pai_value: nil,
                                             as_of: Date.today)
        social.valid?
        expect(social).to be_invalid
      end

      it 'fails to create an additional pai social when social_pai_value is negative' do
        social = AdditionalPaisSocial.create(institution_id: institution.id,
                                             social_pai_reported: 'E11',
                                             social_pai_value: -10,
                                             as_of: Date.today)
        social.valid?
        expect(social).to be_invalid
      end

      it 'fails to create an additional pai social when social_pai_value is over 100 and social_pai_reported is %' do
        social = AdditionalPaisSocial.create(institution_id: institution.id,
                                             social_pai_reported: 'E11',
                                             social_pai_value: 120,
                                             as_of: Date.today)
        social.valid?
        expect(social).to be_invalid
      end
    end
  end
end
