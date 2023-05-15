# frozen_string_literal: true

FactoryBot.define do
  factory :institution_provision do
    institution
    creation_user factory: :user

    percentage { rand(100) }
    previous_percentage_of_provision { 0 }
    new_percentage_of_provision { percentage }
    comment { FFaker::Lorem.sentence }
  end
end
