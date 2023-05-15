# frozen_string_literal: true

class InstitutionInvestmentManager < ApplicationRecord
  acts_as_paranoid

  belongs_to :institution
  belongs_to :investment_manager, class_name: "User"
end
