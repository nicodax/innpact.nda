# frozen_string_literal: true

FactoryBot.define do
  factory :loan_version do
    loan
    currency
    repayment_type
    loan_type
    pool { association :pool, :global }
    creation_user { FactoryBot.create(:user) }
    probabilities { 99.9 }
    version_number { 1 }
    SysStartTime { Time.zone.today }
    SysEndTime { Time.zone.today + 1.year }
    provision_date { Time.zone.today + 1.month }
    nav_date { Time.zone.today - 1.month }
    vrr_maturity_date { Time.zone.today + 1.month }
    created_at { Time.zone.today - 1.month }
    updated_at { Time.zone.today }

    trait :assigned do
      status { LoanVersion::STATUS_ASSIGNED }
      proposed_nominal_amount { 50.3 }
      proposed_tenor { 50.3 }
      proposed_spread { 50.3 }
      proposed_upfront_fees { 50.3 }
      proposed_fixed_rate { 50.3 }
      assignment_date { Time.zone.today + 1.month }
      deadline_assignment_date { Time.zone.today + 1.month }
      expected_disbursement_date { Time.zone.today + 1.month }
    end

    trait :appetite_inquiry do
      assigned
      status { LoanVersion::STATUS_APPETITE_INQUIRY }
    end

    trait :pending_ratification do
      assigned
      status { LoanVersion::STATUS_PENDING_RATIFICATION }
      pending_ratification_nominal_amount { 50.3 }
      pending_ratification_tenor { 50.3 }
      pending_ratification_spread { 50.3 }
      pending_ratification_upfront_fees { 50.3 }
      pending_ratification_fixed_rate { 50.3 }
      pending_ratification_date { Time.zone.today + 1.month }
      deadline_pending_ratification_date { Time.zone.today + 1.month }
      expected_disbursement_date { Time.zone.today + 1.month }
    end

    trait :ratified do
      assigned
      status { LoanVersion::STATUS_RATIFIED }
      ratified_nominal_amount { 50.3 }
      ratified_tenor { 50.3 }
      ratified_spread { 50.3 }
      ratified_upfront_fees { 50.3 }
      ratified_fixed_rate { 50.3 }
      ratification_date { Time.zone.today + 1.month }
      deadline_ratification_date { Time.zone.today + 1.month }
      expected_disbursement_date { Time.zone.today + 1.month }
    end

    trait :pending_approval do
      ratified
      status { LoanVersion::STATUS_PENDING_APPROVAL }
      pending_approval_nominal_amount { 50.3 }
      pending_approval_tenor { 50.3 }
      pending_approval_spread { 50.3 }
      pending_approval_upfront_fees { 50.3 }
      pending_approval_fixed_rate { 50.3 }
      pending_approval_date { Time.zone.today + 1.month }
      deadline_pending_approval_date { Time.zone.today + 1.month }
      expected_disbursement_date { Time.zone.today + 1.month }
    end

    trait :approved do
      ratified
      status { LoanVersion::STATUS_APPROVED }
      approved_nominal_amount { 50.3 }
      approved_tenor { 50.3 }
      approved_spread { 50.3 }
      approved_upfront_fees { 50.3 }
      approved_fixed_rate { 50.3 }
      approval_date { Time.zone.today + 1.month }
      approved_bond_id { association(:bond) }
      approved_interest_rate_type_id { association(:interest_rate_type) }
      deadline_approval_date { Time.zone.today + 1.month }
      expected_disbursement_date { Time.zone.today + 1.month }
    end

    trait :approved_change_request do
      approved
      status { LoanVersion::STATUS_APPROVED_CHANGE_REQUEST }
      approved_change_request_nominal_amount { 50.3 }
      approved_change_request_tenor { 50.3 }
      approved_change_request_spread { 50.3 }
      approved_change_request_upfront_fees { 50.3 }
      approved_change_request_fixed_rate { 50.3 }
      approval_change_request_date { Time.zone.today + 1.month }
      deadline_approval_change_request_date { Time.zone.today + 1.month }
      expected_disbursement_date { Time.zone.today + 1.month }
    end

    trait :invested do
      approved
      status { LoanVersion::STATUS_INVESTED }
      executed_nominal_amount { 50.3 }
      executed_tenor { 50.3 }
      loan_spread { 50.3 }
      executed_upfront_fees { 50.3 }
      executed_fixed_rate { 50.3 }
      disbursement_date { Time.zone.today + 1.month }
      maturity_date { Time.zone.today + 1.month }
      executed_bond { association(:bond) }
      approved_bond_id { association(:bond) }
      loan_interest_rate_type { association(:interest_rate_type) }
      approved_interest_rate_type_id { association(:interest_rate_type) }
      expected_disbursement_date { Time.zone.today + 1.month }
    end

    trait :matured do
      approved
      status { LoanVersion::STATUS_MATURED }
      executed_nominal_amount { 50.3 }
      executed_tenor { 50.3 }
      loan_spread { 50.3 }
      executed_upfront_fees { 50.3 }
      executed_fixed_rate { 50.3 }
      disbursement_date { Time.zone.today - 1.month }
      maturity_date { Time.zone.today - 1.month }
      executed_bond { association(:bond) }
      approved_bond_id { association(:bond) }
      loan_interest_rate_type { association(:interest_rate_type) }
      approved_interest_rate_type_id { association(:interest_rate_type) }
      expected_disbursement_date { Time.zone.today - 1.month }
    end
  end
end
