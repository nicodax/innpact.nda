# frozen_string_literal: true

class FundsUser < ApplicationRecord
  belongs_to :fund
  belongs_to :user
end
