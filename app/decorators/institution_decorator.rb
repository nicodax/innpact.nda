include ActionView::Helpers::NumberHelper

class InstitutionDecorator < ApplicationDecorator
  decorates Institution
  decorates_association :institution_provisions
  # TODO : TO BE DELETED AFTER REFACTORING
  # decorates_association :institution_esg_safeguards
  # decorates_association :institution_esg_risks
  decorates_association :institution_esg_pai_indicators

  [:microfinance_portfolio_size, :sme_portfolio_size_under_35k, :liabilities, :domestic_liabilities, :international_liabilities,
   :revenues, :net_income_distributed_as_dividends, :provision_for_loss, :write_off, :deposit_amount, :saving_amount,
   :services, :production, :microenterprise_usd, :sme_usd, :corporate_usd, :housing_usd, :personal_usd, :other_usd,
   :trade, :agriculture, :education, :housing, :consumption, :other, :total_assets, :gross_loan_portfolio,
   :portfolio_3y_ago, :equity, :other_liabilities, :net_income, :avg_loan_size, :sme_portfolio_size_under_50k].each do |attr|
    define_method "#{attr}_currency_value" do
      number_to_currency(object.send(attr), unit: '')
    end
  end

  # #decimal value with $
  [:total_assets, :equity, :liabilities, :domestic_liabilities, :international_liabilities, :other_liabilities,
   :revenues, :provision_for_loss, :deposit_amount, :saving_amount, :net_income,
   :gross_loan_portfolio, :portfolio_3y_ago, :microfinance_portfolio_size, :sme_portfolio_size_under_35k,
   :sme_portfolio_size_under_50k, :microenterprise_usd, :sme_usd, :corporate_usd, :housing_usd, :personal_usd,
   :other_usd, :avg_loan_size, :npls, :write_off, :net_income_distributed_as_dividends].each do |attr|
    define_method "#{attr}_usd_value" do
      number_to_currency(object.send(attr), format: '%n %u')
    end
  end

  # #integer value without $
  [:borrowers_count, :female_borrowers_count, :rural_borrowers_count, :number_of_micro_borrowers, :number_of_sme_borrowers, :number_of_clients,
   :number_clients_using_mobile_banking, :number_clients_with_deposits].each do |attr|
    define_method "#{attr}_integer_value" do
      number_with_delimiter(object.send(attr))
    end
  end

  #decimal percentage value
  [:net_income_distributed_as_dividends, :overall_sptf_alinus_score, :define_and_monitor_social_goals, :ensure_commitment_to_social_goals,
   :product_design_to_meet_clients_need, :treat_clients_responsibly, :treat_employees_responsibly, :balance_financial_and_performance,
   :agriculture, :production, :consumption, :by_sector_other,
   :promote_environmental_protection, :trade_and_services, :probability_of_default,
   :percentage_rural_ptf, :percentage_of_women_ptf, :microenterprise, :corporate,
   :sme, :housing, :personal, :by_loan_purpose_other].each do |attr|
    define_method "#{attr}_percent_value" do
      number_to_percentage(object.send(attr), precision: 2, delimiter: ',', separator: '.', format: '%n %')
    end
  end

  def upcoming_repayment_lines
    RepaymentCalendarLineDecorator.decorate_collection(RepaymentCalendarLine.for_loan_ids(institution_user_loans.map(&:id)).pending_status.order(repayment_date: :asc)).where('repayment_date >= ?', Time.zone.now)
  end

  def institution_user_loans
    LoanPolicy::Scope.new(h.current_user, Loan.for_institution(object)).resolve
  end

  def country_group_name
    institution.country&.country_group&.name
  end

  def month_in_watchlist
    (Time.now.year * 12 + Time.now.month) - (object.watchlist_entry_date.year * 12 + object.watchlist_entry_date.month)
  end

  def critical_case_types
    types = ''
    types = I18n.t('activerecord.attributes.institution.criticical_cases.watchlist') if institution.in_watchlist?
    types = types + I18n.t('activerecord.attributes.institution.criticical_cases.restructuring') if institution.restructuring?
    types = types + I18n.t('activerecord.attributes.institution.criticical_cases.provision') if institution.provision?
    return types.chomp(', ')
  end

  def active_loans
    LoanDecorator.decorate_collection(institution_user_loans.invested)
  end

  def pipeline_loans
    LoanDecorator.decorate_collection(institution_user_loans.pipeline_loans)
  end

  def im_groups
    fund.im_groups.pluck(:name, :id)
  end

  def currency_label
    currency.short_name
  end

  def formatted_current_provision_percentage
    number_to_percentage(current_provision_percentage * 100, precision: 2)
  end

  def tier_label
    InstitutionProfile.tier_map[institution.tier]
  end

  def distribution_by_sector_total
    total = [object.trade_and_services, object.agriculture, object.production, object.consumption, object.by_sector_other].compact.sum
    number_to_percentage(total, precision: 2, delimiter: ',', separator: '.', format: "%n %")
  end

  def distribution_by_loan_purpose_total_percent_value
    total = [object.microenterprise, object.sme, object.corporate, object.housing, object.personal, object.by_loan_purpose_other].compact.sum
    number_to_percentage(total, precision: 2, delimiter: ',', separator: '.', format: '%n %')
  end

  # TODO : TO BE DELETED AFTER REFACTORING
  # def last_institution_esg_sdg_contribution
  #   last_institution_esg_sdg_contribution = institution_esg_sdg_contributions.order(as_of: :asc)
  #   return unless last_institution_esg_sdg_contribution.presence

  #   last_institution_esg_sdg_contribution.where(as_of: last_institution_esg_sdg_contribution.last.as_of).order(updated_at: :asc).last
  # end

  def last_institution_esg_gender_equality
    institution_esg_gender_equalities.order(as_of: :desc, updated_at: :desc).first_or_initialize.decorate
  end

  def last_institution_esg_safeguard
    last_institution_esg_safeguard = institution_esg_safeguards.order(as_of: :asc)
    return unless last_institution_esg_safeguard.presence

    last_institution_esg_safeguard.where(as_of: last_institution_esg_safeguard.last.as_of).order(updated_at: :asc).last
  end

  def last_institution_esg_risk
    last_institution_esg_risk = institution_esg_risks.order(as_of: :asc)
    return unless last_institution_esg_risk.presence

    last_institution_esg_risk.where(as_of: last_institution_esg_risk.last.as_of).order(updated_at: :asc).last
  end

  def last_institution_esg_pai_indicator
    last_institution_esg_pai_indicator = institution_esg_pai_indicators.order(as_of: :asc)
    return unless last_institution_esg_pai_indicator.presence

    last_institution_esg_pai_indicator.where(as_of: last_institution_esg_pai_indicator.last.as_of).order(updated_at: :asc).last
  end

  def dropdown_yes_no_list_display(field)
    return 'dropdown_list.yes_no_list.no_data' if field.nil?

    return field ? 'dropdown_list.yes_no_list.yes' : 'dropdown_list.yes_no_list.no'
  end
end
