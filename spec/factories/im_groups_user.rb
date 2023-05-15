# frozen_string_literal: true

FactoryBot.define do
  factory :im_groups_user do
    im_group
    user
  end
end
