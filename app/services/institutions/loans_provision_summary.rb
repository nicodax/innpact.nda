# frozen_string_literal: true

module Institutions
  class EmptyInstitution < StandardError
    def initialize(message = 'Institution no exists.')
      super(message)
    end
  end

  class LoansProvisionSummary
    def call(institution:)
      @institution = institution
      raise EmptyInstitution if @institution.blank?

      set_defaults
      calculate_summary
      create_result
    end

    private

    def set_defaults
      @gross_exposure = 0
      @provision_amount = 0
      @net_amount = 0
    end

    def calculate_summary
      @institution.loans.invested.includes(loan_versions: { currency: :currency_rates }).each do |loan|
        @gross_exposure += loan.active_loan_version.gross_position_value_usd || 0
        @provision_amount += loan.active_loan_version.provision_value_usd || 0
        @net_amount += loan.active_loan_version.net_position_value_usd || 0
      end
    end

    def create_result
      {
        gross_exposure: @gross_exposure,
        provision_amount: @provision_amount,
        net_amount: @net_amount
      }
    end
  end
end
