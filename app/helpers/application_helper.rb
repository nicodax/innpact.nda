module ApplicationHelper
  include ActionView::Helpers::NumberHelper

  def vertical_menu
    [
      { section_name: "bonds", model: Bond },
      { section_name: "countries", model: Country },
      { section_name: "country_groups", model: CountryGroup },
      { section_name: "currencies", model: Currency },
      { section_name: "im_groups", model: ImGroup },
      { section_name: "institutions", model: Institution, children: [{ model: InstitutionCovenant, section_name: "covenants"}] },
      { section_name: "institution_groups", model: InstitutionGroup },
      { section_name: "institution_types", model: InstitutionType },
      { section_name: "interest_rate_types", model: InterestRateType },
      { section_name: "limits", model: DefaultLimit },
      { section_name: "loan_types", model: LoanType },
      { section_name: "pools", model: Pool },
      { section_name: "readers", model: User },
      { section_name: "repayment_types", model: RepaymentType },
      { section_name: "statuses", model: Status }
    ]
  end

  def big_decimal_to_percentage(value)
    return unless value.present?

    "#{value.to_s('F')}%"
  end

  def format_pai_with_unit(value, unit)
    case unit
    when '%'
      number_to_percentage(value, precision: 7, delimiter: ',', separator: '.', format: '%n %')
    when '#'
      number_to_currency(value, unit: '', precision: 0)
    when 't/million USD'
      number_to_currency(value, format: '%n t/million USD', precision: 7)
    when 'm3/million USD'
      number_to_currency(value, format: '%n m3/million USD', precision: 7)
    else
      value
    end
  end
end
