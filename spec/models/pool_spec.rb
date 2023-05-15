# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Pool do
  include_context 'shared factories'

  let(:name) { FFaker::Lorem.word }
  let(:currency) { create(:currency, fund: fund) }
  let(:country) { create(:country, fund: fund) }
  let(:institution_group) { create(:institution_group, fund: fund) }
  let(:institution_type) { create(:institution_type, fund: fund) }
  let(:country_group) { create(:country_group, fund: fund) }
  let(:loan_type) { create(:loan_type, fund: fund) }
  let(:document) do
    Rack::Test::UploadedFile.new(File.open(Rails.root.join('spec', 'fixtures', 'files', 'test_pdf.pdf')))
  end

  it 'is valid with valid parameters' do
    pool = fund.pools.new(name: name, currency: currency, subscription_date: Date.today - 1.day, amount: 1000,
                          amount_in_usd: 1000)
    expect(pool).to be_valid
  end

  it 'is not valid without name' do
    pool = fund.pools.new(name: nil, currency: currency, subscription_date: Date.today - 1.day, amount: 1000,
                          amount_in_usd: 1000)
    expect(pool).not_to be_valid
  end

  it 'is not valid without currency' do
    pool = fund.pools.new(name: name, currency: nil, subscription_date: Date.today - 1.day, amount: 1000,
                          amount_in_usd: 1000)
    expect(pool).not_to be_valid
  end

  it 'is not valid without subscription_date' do
    pool = fund.pools.new(name: name, currency: currency, subscription_date: nil, amount: 1000, amount_in_usd: 1000)
    expect(pool).not_to be_valid
  end

  it 'is not valid without maturity_date if has maturity date' do
    pool = fund.pools.new(name: name, currency: currency, subscription_date: Date.today - 1.day, amount: 1000,
                          amount_in_usd: 1000, has_maturity_date: true)
    expect(pool).not_to be_valid
  end

  it 'is not valid without amount' do
    pool = fund.pools.new(name: name, currency: currency, subscription_date: Date.today - 1.day, amount: nil,
                          amount_in_usd: 1000)
    expect(pool).not_to be_valid
  end

  it 'is not valid without amount_in_usd' do
    pool = fund.pools.new(name: name, currency: currency, subscription_date: Date.today - 1.day, amount: 1000,
                          amount_in_usd: nil)
    expect(pool).not_to be_valid
  end

  it 'is not valid with subscription_date in the future' do
    pool = fund.pools.new(name: name, currency: currency, subscription_date: Date.today + 1.day, amount: 1000,
                          amount_in_usd: 1000)
    expect(pool).not_to be_valid
  end

  it 'is not valid with maturity_date in the past' do
    pool = fund.pools.new(name: name, currency: currency, subscription_date: Date.today - 1.day, amount: 1000,
                          amount_in_usd: 1000, has_maturity_date: true, maturity_date: Date.today - 1.day)
    expect(pool).not_to be_valid
  end

  it 'is not valid if targeted without restriction' do
    pool = fund.pools.new(name: name, currency: currency, subscription_date: Date.today - 1.day, amount: 1000,
                          amount_in_usd: 1000, is_targeted: true)
    expect(pool).not_to be_valid
  end

  it 'can be destroyed' do
    pool = fund.pools.create(name: name, currency: currency, subscription_date: Date.today - 1.day, amount: 1000,
                             amount_in_usd: 1000)
    pool_id = pool.id

    PoolTarget.create(pool: pool, amount_in_usd: 1000)
    PoolCountry.create(pool: pool, country: country)
    PoolInstitution.create(pool: pool, institution: institution)
    PoolInstitutionGroup.create(pool: pool, institution_group: institution_group)
    PoolInstitutionType.create(pool: pool, institution_type: institution_type)
    PoolCountryGroup.create(pool: pool, country_group: country_group)
    PoolCurrency.create(pool: pool, currency: currency)
    PoolLoanType.create(pool: pool, loan_type: loan_type)
    PoolDocument.create(pool: pool, document: document)
    PoolLegalDocument.create(pool: pool, document: document)

    expect(Pool.only_deleted.where(id: pool_id)).to be_truthy
    expect(PoolTarget.only_deleted.where(pool_id: pool_id)).to be_truthy
    expect(PoolCountry.only_deleted.where(pool_id: pool_id)).to be_truthy
    expect(PoolInstitution.only_deleted.where(pool_id: pool_id)).to be_truthy
    expect(PoolInstitutionGroup.only_deleted.where(pool_id: pool_id)).to be_truthy
    expect(PoolInstitutionType.only_deleted.where(pool_id: pool_id)).to be_truthy
    expect(PoolCountryGroup.only_deleted.where(pool_id: pool_id)).to be_truthy
    expect(PoolCurrency.only_deleted.where(pool_id: pool_id)).to be_truthy
    expect(PoolLoanType.only_deleted.where(pool_id: pool_id)).to be_truthy
    expect(PoolDocument.only_deleted.where(pool_id: pool_id)).to be_truthy
    expect(PoolLegalDocument.only_deleted.where(pool_id: pool_id)).to be_truthy
  end

  it 'can be completely destroyed' do
    pool = Pool.create!(fund: fund, name: name, currency: currency, subscription_date: Date.today - 1.day, amount: 1000,
                        amount_in_usd: 1000)
    pool_id = pool.id

    PoolTarget.create(pool: pool, amount_in_usd: 1000)
    PoolCountry.create(pool: pool, country: country)
    PoolInstitution.create(pool: pool, institution: institution)
    PoolInstitutionGroup.create(pool: pool, institution_group: institution_group)
    PoolInstitutionType.create(pool: pool, institution_type: institution_type)
    PoolCountryGroup.create(pool: pool, country_group: country_group)
    PoolCurrency.create(pool: pool, currency: currency)
    PoolLoanType.create(pool: pool, loan_type: loan_type)
    PoolDocument.create(pool: pool, document: document)
    PoolLegalDocument.create(pool: pool, document: document)

    pool.really_destroy!

    expect(Pool.only_deleted.where(id: pool_id)).to be_empty
    expect(PoolTarget.only_deleted.where(pool_id: pool_id)).to be_empty
    expect(PoolCountry.only_deleted.where(pool_id: pool_id)).to be_empty
    expect(PoolInstitution.only_deleted.where(pool_id: pool_id)).to be_empty
    expect(PoolInstitutionGroup.only_deleted.where(pool_id: pool_id)).to be_empty
    expect(PoolInstitutionType.only_deleted.where(pool_id: pool_id)).to be_empty
    expect(PoolCountryGroup.only_deleted.where(pool_id: pool_id)).to be_empty
    expect(PoolCurrency.only_deleted.where(pool_id: pool_id)).to be_empty
    expect(PoolLoanType.only_deleted.where(pool_id: pool_id)).to be_empty
    expect(PoolDocument.only_deleted.where(pool_id: pool_id)).to be_empty
    expect(PoolLegalDocument.only_deleted.where(pool_id: pool_id)).to be_empty
  end
end
