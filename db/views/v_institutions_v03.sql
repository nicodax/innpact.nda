SELECT 
		institutions.general_as_of_date AS general_time_stamp,
		institutions.name,
		im_groups.name As assigned_IM_group,
		countries.name AS country,
		institution_groups.name AS institution_group,
		institution_types.name AS institution_type,
		institutions.ia_esg_rating,
		institutions.internal_rating,
		institutions.external_rating AS external_rating_moody,
		institutions.tier,
		institutions.environmental_rating,
		institutions.cpps_adoption,
		institutions.kyc_check,
		institutions.use_of_standard_reporting_tools,
		institutions.involvement_in_responsible_finance_initiatives,
		institutions.training_on_responsible_finance_targeting_women,
		institutions.provision_of_financial_products_targeting_enterprise_set_up,
		institutions.financials_as_of_date AS financials_time_stamp,
		institutions.total_assets,
		institutions.equity,
		institutions.liabilities,
		institutions.domestic_liabilities,
		institutions.international_liabilities,
		institutions.other_liabilities,
		institutions.revenues,
		institutions.net_income,
		institutions.net_income_distributed_as_dividends,
		provision_for_loss,
		institutions.write_off,
		institutions.deposits,
		institutions.deposit_amount,
		institutions.saving,
		institutions.saving_amount,
		institutions.mobile_banking_services,
		institutions.list_dfi_lenders,
		institutions.financial_strength_of_shareholders,
		institutions.clients_as_of_date,
		institutions.borrowers_count AS number_active_borrowers,
		institutions.female_borrowers_count AS number_female_borrowers,
		institutions.rural_borrowers_count AS number_rural_borrowers,
		institutions.number_of_micro_borrowers AS number_micro_borrowers,
		institutions.number_of_sme_borrowers AS number_sme_borrowers,
		institutions.avg_loan_size AS average_loan_size,
		institutions.portfolio_breakdown_i_as_of_date AS portfolio_breakdown_I_time_stamp,
		institutions.gross_loan_portfolio,
		institutions.portfolio_3y_ago,
		institutions.microfinance_portfolio_size,
		institutions.sme_portfolio_size,
		institutions.portfolio_breakdown_ii_as_of_date AS portfolio_breakdown_II_distribution_by_sector_time_stamp,
		institutions.trade,
		institutions.services,
		institutions.agriculture,
		institutions.production,
		institutions.education,
		institutions.housing,
		institutions.consumption,
		institutions.other,
		institutions.portfolio_breakdown_iii_as_of_date AS portfolio_breakdown_III_distribution_by_loan_time_stamp,
		institutions.microenterprise_usd,
		institutions.sme_usd,
		institutions.corporate_usd,
		institutions.housing_usd,
		institutions.personal_usd,
		institutions.other_usd,
		institutions.aptf_alinus_results_as_of_date AS aptf_alinus_results_time_stamp,
		institutions.has_sptf_alinus_reporting_using_alinus,
		institutions.sptf_alinus_reporting_using_alinus,
		institutions.overall_sptf_alinus_score,
		institutions.define_and_monitor_social_goals,
		institutions.ensure_commitment_to_social_goals,
		institutions.product_design_to_meet_clients_need,
		institutions.treat_clients_responsibly,
		institutions.treat_employees_responsibly,
		institutions.balance_financial_and_performance,
		institutions.promote_environmental_protection,
		GETDATE() As data_viewed_at

	FROM institutions
		LEFT JOIN funds ON institutions.fund_id = funds.id
		LEFT JOIN im_groups ON im_groups.fund_id = funds.id
		AND im_groups.id = institutions.im_group_id
		LEFT JOIN countries ON countries.fund_id = funds.id
		AND countries.id = institutions.country_id
		LEFT JOIN institution_groups ON institution_groups.fund_id = funds.id
		AND institution_groups.id = institutions.institution_group_id
		LEFT JOIN institution_types ON institution_types.fund_id = funds.id
		AND institution_types.id = institutions.institution_type_id
		
	WHERE 
		institutions.deleted_at IS NULL
		AND institution_groups.deleted_at IS NULL
		AND countries.deleted_at IS NULL
		AND institution_types.deleted_at IS NULL
