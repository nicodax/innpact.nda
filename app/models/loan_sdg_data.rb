# frozen_string_literal: true

class LoanSdgData < ApplicationRecord
  acts_as_paranoid

  belongs_to :loan
  scope :current, ->(presentable_at) { where(presentable_at: presentable_at) }
  scope :latest, ->(loan_id) { where(loan_id: loan_id).order(id: :desc) }

  # TODO: Remove validation as it's currently optional
  # validate :at_least_one_goal

  def at_least_one_goal
    number_of_goals = [
      no_poverty, zero_hunger, good_health_and_wellbeing, quality_education,
      gender_equality, clean_water_and_sanitation, affordable_and_clean_energy,
      descent_work_and_economic_growth, industry_innovation_and_infrastructure,
      reduced_inequalities, sustainable_cities_and_conmmunities,
      responsible_consumption_and_production, climate_action, life_below_water,
      life_on_land, peace_justice_and_strong_institutions,
      partnerships_for_the_goals
    ].count { |x| x }

    return unless number_of_goals < 1 && loan.active_loan_version.presentable_at.present?

    errors.add(:goals, I18n.t('.cannot_be_left_empty'))
  end
end
