# frozen_string_literal: true

require 'rails_helper'

RSpec.describe InstitutionType do
  include_context 'shared factories'

  let(:name) { "Test" }
  let(:description) { "Test description" }

  it 'is valid with valid parameters' do
    institution_type = fund.institution_types.new(name: name, description: description)
    expect(institution_type).to be_valid
  end

  it 'is not valid with invalid parameters' do
    description = "a" * 110
    institution_type = fund.institution_types.new(name: name, description: description)
    expect(institution_type).not_to be_valid
  end

  it 'fails when the description is greater than 100 characters' do
    description = "a" * 110
    institution_type = fund.institution_types.new(name: name, description: description)
    institution_type.valid?
    expect(institution_type.errors.messages[:description]).to eql(["is too long (maximum is 100 characters)"])
  end

end
