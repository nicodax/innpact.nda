# frozen_string_literal: true

class CalculateProvisionValueForLoan
  ProvisionValue = Struct.new(:provision_value, :net_provision_value, :provision_value_usd,
                              :net_provision_value_usd, :currency, keyword_init: true)

  def call(loan:, provision_percentage:)
    return if loan.blank? || provision_percentage.blank?

    repayment_lines_to_provision = RepaymentCalendarLine.for_loan(loan).pending_status.principal
    currency = loan.active_loan_version.currency
    provision_value = calculate_provision_value(repayment_lines_to_provision, provision_percentage)
    net_position_value = loan.gross_position_value - provision_value

    ProvisionValue.new(provision_value: provision_value,
                       currency: currency,
                       net_provision_value: net_position_value,
                       provision_value_usd: exchange_value(provision_value, currency),
                       net_provision_value_usd: exchange_value(net_position_value, currency))
  end

  private

  def exchange_value(value, currency)
    value / currency.current_rate
  end

  def calculate_provision_value(repayment_lines_to_provision, provision_percentage)
    repayment_lines_to_provision.reduce(0) do |memo, repayment_line|
      memo += repayment_line.original_amount * provision_percentage
      memo
    end
  end
end
