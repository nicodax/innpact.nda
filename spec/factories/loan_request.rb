# frozen_string_literal: true

FactoryBot.define do
  factory :loan_request do
    user
    fund
    innpact_loan_id { rand(100_000) }

    trait :valid do
      institution
      repayment_type
      loan_type
      currency
      assigned_investment_manager { user }
      spread { 99.99 }
      upfront_fees { 99.99 }
      fixed_rate { 99.99 }
      nominal_amount_local_currency { 99.99 }
      tenor { 99 }
      execution_probability { 99.99 }
      mfi_pays { LoanRequest::MFI_PAYS_OPTIONS.sample }
      interest_payment_frequency { 99 }
      tranche { 99 }
      intermediary { LoanRequest::INTERMEDIARY_OPTIONS.sample }
      syndication_amount { 99.99 }
      hedge_structure { LoanRequest::HEDGE_STRUCTURE_OPTIONS.sample }
      assignement_date { DateTime.now }
      expected_dibursement_date { DateTime.now + 100.days }
    end
  end
end
