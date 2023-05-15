# frozen_string_literal: true

FactoryBot.define do
  factory :loan do
    fund
    institution
    im_group
    innpact_loan_id { rand(100_000) }
    creation_user { create(:user) }
    last_loan_version { 1 }
  end
end
