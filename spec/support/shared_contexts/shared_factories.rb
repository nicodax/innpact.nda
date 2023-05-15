# frozen_string_literal: true

RSpec.shared_context 'shared factories' do
  before(:all) do
    @general_manager = TestProf::AnyFixture.register(:general_manager) do
      create(:general_manager)
    end

    @investment_manager = TestProf::AnyFixture.register(:investment_manager) do
      create(:investment_manager)
    end

    @second_investment_manager = TestProf::AnyFixture.register(:second_investment_manager) do
      create(:investment_manager)
    end

    @administrator = TestProf::AnyFixture.register(:administrator) do
      create(:administrator)
    end

    @reader = TestProf::AnyFixture.register(:reader) do
      create(:reader)
    end

    @fund = TestProf::AnyFixture.register(:fund) do
      create(:fund)
    end

    @default_im_group = TestProf::AnyFixture.register(:default_im_group) do
      create(:im_group, fund: @fund, user_ids: [@investment_manager.id])
    end

    @institution = TestProf::AnyFixture.register(:institution) do
      create(:institution, fund: @fund, im_group: @default_im_group)
    end


    TestProf::AnyFixture.register(:second_im_group) do
      create(:im_group, fund: @fund, user_ids: [@second_investment_manager.id])
    end

    @currency_usd = TestProf::AnyFixture.register(:currency_usd) do
      create(:currency, fund: @fund, short_name: 'USD')
    end

    @currency_usd_rate = TestProf::AnyFixture.register(:currency_usd_rate) do
      create(:currency_rate, currency: @currency_usd, rate: 1)
    end

    @currency_eur = TestProf::AnyFixture.register(:currency_eur) do
      create(:currency, fund: @fund, short_name: 'EUR')
    end

    @currency_eur_rate = TestProf::AnyFixture.register(:currency_eur_rate) do
      create(:currency_rate, currency: @currency_eur, rate: 1.2)
    end

    TestProf::AnyFixture.register(:country) do
      create(:country, fund: @fund)
    end

    TestProf::AnyFixture.register(:institution_type) do
      create(:institution_type, fund: @fund)
    end

    TestProf::AnyFixture.register(:institution_group) do
      create(:institution_group, fund: @fund)
    end

    TestProf::AnyFixture.register(:institution) do
      create(:institution, im_group: default_im_group, country: country, institution_group: institution_group,
                           institution_type: institution_type)
    end

    TestProf::AnyFixture.register(:bond) do
      create(:bond, fund: @fund)
    end

    TestProf::AnyFixture.register(:interest_rate_type) do
      create(:interest_rate_type ,fund: @fund)
    end
  end

  let(:general_manager) { TestProf::AnyFixture.register(:general_manager) }
  let(:administrator) { TestProf::AnyFixture.register(:administrator) }
  let(:reader) { TestProf::AnyFixture.register(:reader) }
  let(:investment_manager) { TestProf::AnyFixture.register(:investment_manager) }
  let(:second_investment_manager) { TestProf::AnyFixture.register(:second_investment_manager) }
  let(:fund) { TestProf::AnyFixture.register(:fund) }
  let(:institution) { Institution.find(TestProf::AnyFixture.register(:institution).id) }
  let(:currency_usd) { TestProf::AnyFixture.register(:currency_usd) }
  let(:currency_eur) { TestProf::AnyFixture.register(:currency_eur) }
  let(:default_im_group) { TestProf::AnyFixture.register(:default_im_group) }
  let(:second_im_group) { TestProf::AnyFixture.register(:second_im_group) }
  let(:country) { TestProf::AnyFixture.register(:country) }
  let(:institution_group) { TestProf::AnyFixture.register(:institution_group) }
  let(:institution_type) { TestProf::AnyFixture.register(:institution_type) }
  let(:bond) { TestProf::AnyFixture.register(:bond) }
  let(:interest_rate_type) { TestProf::AnyFixture.register(:interest_rate_type) }
end
