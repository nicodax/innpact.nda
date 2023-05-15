require 'rails_helper'

RSpec.describe InstitutionCovenantsImporter do
  let(:testing_array) { ['30%', '30.0%', '30.5%'] }

  it 'returns an array with correct values' do
    convenant_importer = InstitutionCovenantsImporter.new

    result = testing_array.map { |value| convenant_importer.convert_value(value) }
    expected = [30, 30, 30.5]

    expect(result).to match_array(expected)
  end
end
