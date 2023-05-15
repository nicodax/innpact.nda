# frozen_string_literal: true

require 'rails_helper'

RSpec.describe LoansFilter do

  let!(:fund) { create(:fund) }
  let!(:administrator) { create(:administrator) }
  let!(:im_group) { create(:im_group, fund: fund) }
  let!(:im_group_2) { create(:im_group, fund: fund) }
  let!(:country) { create(:country, fund: fund) }
  let!(:institution_group) { create(:institution_group, fund: fund) }
  let!(:institution_type) { create(:institution_type, fund: fund) }
  let!(:country_group) { create(:country_group, fund: fund) }

  let!(:loan_1) { create(:loan, fund: fund, im_group: im_group) }
  let!(:loan_2) { create(:loan, fund: fund, im_group: im_group_2) }

  it "returns all the loans for the given ImGroup when one is specified" do
    filter = LoansFilter.new(Loan.all)
    filter.populate_from_params({ im_group_id: im_group.id  })
    result = filter.loans

    expect(result.size).to eql 1
    expect(result.first.im_group_id).to eql im_group.id
  end

  it "returns an empty array when there is no loan corresponding to the specified ImGroup" do
    filter = LoansFilter.new(Loan.all)
    filter.populate_from_params({ im_group_id: 0 })
    result = filter.loans

    expect(result.size).to eql 0
  end

end
