# frozen_string_literal: true

class InstitutionEsgGenderEqualityDecorator < ApplicationDecorator
  delegate_all

  decorates InstitutionEsgGenderEquality

  def boolean_keys
    %w[
      financial_services_targeting_women
      non_financial_services_targeting_women
      training_on_responsible_finance_targeting_women
    ]
  end

  def percentage_keys
    %w[
      percentage_loans_to_women_borrowers_per_glp
      women_percentage_in_board
      women_percentage_in_management
      women_percentage_in_staff
      percentage_women_among_loan_officers
    ]
  end
end
