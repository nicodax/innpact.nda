# frozen_string_literal: true

class ImGroupsUser < ApplicationRecord
  belongs_to :im_group
  belongs_to :user
end
