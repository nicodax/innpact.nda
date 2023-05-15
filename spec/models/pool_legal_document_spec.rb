# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PoolLegalDocument do
  include_context 'shared factories'

  let!(:pool) { create(:pool, :targeted, fund: fund) }
  let(:document) do
    Rack::Test::UploadedFile.new(File.open(Rails.root.join('spec', 'fixtures', 'files', 'test_pdf.pdf')))
  end
  let(:name) { FFaker::Lorem.word }

  it 'is valid with valid params' do
    pool_legal_document = PoolLegalDocument.new(pool: pool, document: document, original_filename: name)
    expect(pool_legal_document).to be_valid
  end

  it 'is not valid without a document' do
    pool_legal_document = PoolLegalDocument.new(pool: pool, document: nil, original_filename: name)
    expect(pool_legal_document).not_to be_valid
  end

  it 'is not valid with a too long name' do
    pool_legal_document = PoolLegalDocument.new(pool: pool, document: document,
                                                original_filename: FFaker::Lorem.words(100).join(''))
    expect(pool_legal_document).not_to be_valid
  end

  it 'is not valid without pool' do
    pool_legal_document = PoolLegalDocument.new(pool: nil, document: document, original_filename: name)
    expect(pool_legal_document).not_to be_valid
  end

  it 'cannot be destroyed if it is only legal document for the pool' do
    pool_legal_document = PoolLegalDocument.create(pool: pool, document: document, original_filename: name)
    expect(pool_legal_document.destroy).to be_falsey
  end

  it 'can be destroyed if there are several legal document for the pool' do
    first_pool_legal_document = PoolLegalDocument.create(pool: pool, document: document, original_filename: name)
    PoolLegalDocument.create(pool: pool, document: document, original_filename: name)
    expect(first_pool_legal_document.destroy).to be_truthy
  end

  it 'can totally destroy a legal document' do
    pool_legal_document = PoolLegalDocument.create(pool: pool, document: document, original_filename: name)
    pool_legal_document_id = pool_legal_document.id
    PoolLegalDocument.create(pool: pool, document: document, original_filename: name)

    pool_legal_document.destroy

    expect(PoolLegalDocument.only_deleted.where(id: pool_legal_document_id)).to be_truthy

    pool_legal_document.really_destroy!

    expect(PoolLegalDocument.only_deleted.where(id: pool_legal_document_id)).to be_empty
  end
end
