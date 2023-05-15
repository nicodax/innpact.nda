include ActionView::Helpers::NumberHelper

class LoanVersionDecorator < ApplicationDecorator
  [:proposed_nominal_amount_usd, :ratified_nominal_amount_usd, :approved_nominal_amount_usd,
   :executed_nominal_amount_usd, :pending_ratification_nominal_amount_usd, :pending_approval_nominal_amount_usd,
   :approved_change_request_nominal_amount_usd, :gross_position_value_usd, :net_position_value_usd,
   :provision_value_usd, :nav_usd].each do |attr|
    define_method "formatted_#{attr}" do
      number_to_currency(object.send(attr), unit: "$", format: "%n %u")
    end
  end

  [:proposed_tenor, :ratified_tenor, :approved_tenor, :executed_tenor, :pending_ratification_tenor,
   :pending_approval_tenor, :approved_change_request_tenor].each do |attr|
    define_method "formatted_#{attr}" do
      number_to_currency(object.send(attr), unit: "")
    end
  end

  [:proposed_nominal_amount, :ratified_nominal_amount,
   :approved_nominal_amount, :executed_nominal_amount,
   :pending_ratification_nominal_amount, :pending_approval_nominal_amount,
   :approved_change_request_nominal_amount, :gross_position_value, :net_position_value, :provision_value].each do |attr|
    define_method "formatted_#{attr}" do
      number_to_currency(object.send(attr), unit: currency.short_name, format: "%n %u")
    end
  end

  [
    :proposed_spread, :ratified_spread, :approved_spread, :loan_spread, :hedge_spread, :pending_ratification_spread,
    :pending_approval_spread, :approved_change_request_spread, :proposed_fixed_rate, :ratified_fixed_rate,
    :approved_fixed_rate, :executed_fixed_rate, :pending_ratification_fixed_rate, :pending_approval_fixed_rate,
    :approved_change_request_fixed_rate, :proposed_upfront_fees, :ratified_upfront_fees, :approved_upfront_fees,
    :executed_upfront_fees, :pending_ratification_upfront_fees, :pending_approval_upfront_fees, :approved_change_request_upfront_fees,
    :probabilities
  ].each do |attr|
    define_method "formatted_#{attr}" do
      number_to_percentage(object.send(attr), precision: 2)
    end
  end

  def presentable
    object.presentable_at.present?
  end
end
