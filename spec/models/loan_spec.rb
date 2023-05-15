# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Loan do
  include_context 'shared factories'

    let!(:loan_1) do
        create(:loan, institution_id: institution.id, im_group: default_im_group,
                  innpact_loan_id: rand(1000), last_loan_version: 1, fund: fund,
                  creation_user: investment_manager)
    end
    let!(:loan_2) do
        create(:loan, institution_id: institution.id, im_group: default_im_group,
                    innpact_loan_id: rand(1000), last_loan_version: 1, fund: fund,
                    creation_user: investment_manager)
    end
    let!(:loan_3) do
        create(:loan, institution_id: institution.id, im_group: default_im_group,
                    innpact_loan_id: rand(1000), last_loan_version: 1, fund: fund,
                    creation_user: investment_manager)
    end
    let!(:loan_4) do
        create(:loan, institution_id: institution.id, im_group: default_im_group,
                    innpact_loan_id: rand(1000), last_loan_version: 2, fund: fund,
                    creation_user: investment_manager)
    end
    let!(:loan_version_1) do
        create(:loan_version, :invested, loan: loan_1,
                                        version_status: LoanVersion::VERSION_STATUS_VALIDATED,
                                        version_number: 1, validation_user: administrator,
                                        creation_user: investment_manager,
                                        maturity_date: Date.today - 1.day
                                    )
    end
    let!(:loan_version_2) do
        create(:loan_version, :invested, loan: loan_2,
                                        version_status: LoanVersion::VERSION_STATUS_VALIDATED,
                                        version_number: 1, 
                                        creation_user: investment_manager,
                                        validation_user: administrator,
                                        maturity_date: Date.today + 1.day
                                    )
    end
    let!(:loan_version_3) do
        create(:loan_version, :invested, loan: loan_3,
                                        version_status: LoanVersion::VERSION_STATUS_VALIDATED,
                                        version_number: 1, 
                                        creation_user: investment_manager,
                                        validation_user: administrator,
                                        maturity_date: Date.today - 2.day
                                    )
    end
    let!(:loan_version_4_1) do
        create(:loan_version, :invested, loan: loan_4,
                                        version_status: LoanVersion::VERSION_STATUS_VALIDATED,
                                        version_number: 1, 
                                        creation_user: investment_manager,
                                        validation_user: administrator,
                                        maturity_date: Date.today - 3.day
                                    )
    end
    let!(:loan_version_4_2) do
        create(:loan_version, :invested, loan: loan_4,
                                        version_status: LoanVersion::VERSION_STATUS_VALIDATED,
                                        version_number: 2, 
                                        creation_user: investment_manager,
                                        validation_user: administrator,
                                        maturity_date: Date.today - 1.day
                                    )
    end
    it 'test maturity_date_was_yesterday scope is querying the loans from with maturity date expiring yesterday' do
        maturity_date_was_yesterday = Loan.maturity_date_was_yesterday
        expect(maturity_date_was_yesterday).to match_array([loan_1, loan_4])
        expect(maturity_date_was_yesterday).not_to include(loan_2, loan_3)
    end
end
