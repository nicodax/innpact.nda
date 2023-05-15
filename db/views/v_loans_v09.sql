SELECT
	loan_versions.id AS loan_version_id,
	loan_versions.loan_id,
	loan_versions.version_number,
	loan_versions.status,
	loan_versions.version_status,
	loan_versions.currency_id,
	loan_versions.loan_type_id,
	loan_versions.repayment_type_id,
	loan_versions.creation_user_id,
	loan_versions.assignment_date,
	loan_versions.deadline_assignment_date,
	loan_versions.ratification_date,
	loan_versions.deadline_ratification_date,
	loan_versions.approval_date,
	loan_versions.deadline_approval_date,
	loan_versions.expected_disbursement_date,
	loan_versions.specific_approval_condition,
	loan_versions.probabilities,
	loan_versions.disbursement_date,
	loan_versions.in_waiting_list,
	loan_versions.maturity_date,
	loan_versions.nav_usd,
	loan_versions.net_position_value,
	loan_versions.gross_position_value,
	loan_versions.critical_cases,
	loan_versions.provision_date,
	loan_versions.provision_value,
	loan_versions.vrr,
	loan_versions.vrr_maturity_date,
	loan_versions.proposed_nominal_amount,
	loan_versions.proposed_tenor,
	loan_versions.proposed_spread,
	loan_versions.proposed_upfront_fees,
	loan_versions.proposed_fixed_rate,
	loan_versions.ratified_nominal_amount,
	loan_versions.ratified_tenor,
	loan_versions.ratified_spread,
	loan_versions.ratified_upfront_fees,
	loan_versions.ratified_fixed_rate,
	loan_versions.approved_nominal_amount,
	loan_versions.approved_tenor,
	loan_versions.approved_spread,
	loan_versions.approved_upfront_fees,
	loan_versions.approved_fixed_rate,
	loan_versions.executed_nominal_amount,
	loan_versions.executed_tenor,
	loan_versions.executed_spread,
	loan_versions.executed_upfront_fees,
	loan_versions.executed_fixed_rate,
	loan_versions.pending_ratification_nominal_amount,
	loan_versions.pending_ratification_tenor,
	loan_versions.pending_ratification_spread,
	loan_versions.pending_ratification_upfront_fees,
	loan_versions.pending_ratification_fixed_rate,
	loan_versions.pending_ratification_date,
	loan_versions.deadline_pending_ratification_date,
	loan_versions.pending_approval_nominal_amount,
	loan_versions.pending_approval_tenor,
	loan_versions.pending_approval_spread,
	loan_versions.pending_approval_upfront_fees,
	loan_versions.pending_approval_fixed_rate,
	loan_versions.pending_approval_date,
	loan_versions.deadline_pending_approval_date,
	loan_versions.approved_change_request_nominal_amount,
	loan_versions.approved_change_request_tenor,
	loan_versions.approved_change_request_spread,
	loan_versions.approved_change_request_upfront_fees,
	loan_versions.approved_change_request_fixed_rate,
	loan_versions.approval_change_request_date,
	loan_versions.deadline_approval_change_request_date,
	loan_versions.validation_user_id,
	loan_versions.rejection_user_id,
	loan_versions.created_at,
	loan_versions.updated_at,
	loan_versions.deleted_at,
	loan_versions.executed_bond_id,
	loan_versions.pool_id,
	loan_versions.executed_interest_rate_type_id,
	loan_versions.invested_hedge,
	loan_versions.pending_ratification_comment,
	loan_versions.ratified_comment,
	loan_versions.not_ratified_comment,
	loan_versions.assignement_expired_comment,
	loan_versions.released_before_approval_comment,
	loan_versions.pending_approval_comment,
	loan_versions.approved_comment,
	loan_versions.not_approved_comment,
	loan_versions.approval_expired_comment,
	loan_versions.approved_change_request_comment,
	loan_versions.invested_comment,
	loan_versions.released_after_approval_comment,
	loan_versions.not_validated_comment,
	loan_versions.nav_date,
	loan_versions.approved_bond_id,
	loan_versions.approved_interest_rate_type_id,
	loan_versions.number_of_disbursement_date_updates,
	loan_versions.invested_hedge_fx_rate,
	loans.innpact_loan_id,
	loans.institution_mode_at_creation,
	loans.last_loan_version,
	loans.noval,
	loans.restructuring,
	loans.original_loan_id AS tranche_original_loan_id,
	loan_versions.proposed_nominal_amount / currency_rates.rate AS proposed_nominal_amount_USD,
	loan_versions.ratified_nominal_amount / currency_rates.rate AS ratified_nominal_amount_USD,
	loan_versions.approved_nominal_amount / currency_rates.rate AS approved_nominal_amount_USD,
	loan_versions.executed_nominal_amount / currency_rates.rate AS executed_nominal_amount_USD,
	loan_versions.pending_ratification_nominal_amount / currency_rates.rate AS pending_ratification_nominal_amount_USD,
	loan_versions.pending_approval_nominal_amount / currency_rates.rate AS pending_approval_nominal_amount_USD,
	loan_versions.approved_change_request_nominal_amount / currency_rates.rate AS approved_change_request_nominal_amount_USD,
	institutions.name AS Institutions,
	institution_groups.name AS Institution_group,
	institutions.in_watchlist AS in_watchlist,
	institution_types.name AS institution_type,
	funds.name AS fund_name,
	funds.status AS fund_status,
	loan_types.description AS loan_type_description,
	loan_types.name AS loan_type,
	countries.name AS Country,
	countries.rating AS rating_MOODYS,
	countries.mimosa_score AS rating_MIMOSA,
	country_groups.name AS Region,
	currencies.short_name AS Local_Currency,
	currency_rates.rate AS Local_Currency_Rate,
	repayment_types.name AS repayment_type,
	bonds.name AS bond,
	bonds.description AS bond_description,
	interest_rate_types.name AS interest_rate_type,
	interest_rate_types.description AS interest_rate_type_description,
	pools.name AS pool,
	im_groups.name AS IM_Group,
	IIF(loan_versions.presentable_at IS NOT NULL, 'yes', 'no') as presentable,
	loan_versions.presentable_at,
	loan_sdg_data.no_poverty AS sdg_goal_01,
	loan_sdg_data.zero_hunger AS sdg_goal_02,
	loan_sdg_data.good_health_and_wellbeing AS sdg_goal_03,
	loan_sdg_data.quality_education AS sdg_goal_04,
	loan_sdg_data.gender_equality AS sdg_goal_05,
	loan_sdg_data.clean_water_and_sanitation AS sdg_goal_06,
	loan_sdg_data.affordable_and_clean_energy AS sdg_goal_07,
	loan_sdg_data.descent_work_and_economic_growth AS sdg_goal_08,
	loan_sdg_data.industry_innovation_and_infrastructure AS sdg_goal_09,
	loan_sdg_data.reduced_inequalities AS sdg_goal_10,
	loan_sdg_data.sustainable_cities_and_conmmunities AS sdg_goal_11,
	loan_sdg_data.responsible_consumption_and_production AS sdg_goal_12,
	loan_sdg_data.climate_action AS sdg_goal_13,
	loan_sdg_data.life_below_water AS sdg_goal_14,
	loan_sdg_data.life_on_land AS sdg_goal_15,
	loan_sdg_data.peace_justice_and_strong_institutions AS sdg_goal_16,
	loan_sdg_data.partnerships_for_the_goals AS sdg_goal_17,
	presentation_compliance_checks.proposed_investment_complies_with_mef_guidelines,
	presentation_compliance_checks.investee_microfinance_portfolio_greater_than_two_times_mef_loan,
	presentation_compliance_checks.kyc_check,
	presentation_compliance_checks.aml_risk_rate,
	presentation_compliance_checks.aml_country_risk_assessment,
	presentation_compliance_checks.tax_report_assessment,
	GETDATE() As data_viewed_at
FROM loans
	LEFT JOIN funds ON loans.fund_id = funds.id
	LEFT JOIN loan_versions ON loan_versions.loan_id = loans.id
	LEFT JOIN loan_types ON funds.id = loan_types.fund_id AND loan_types.id = loan_versions.loan_type_id
	LEFT JOIN interest_rate_types ON interest_rate_types.fund_id = funds.id AND interest_rate_types.id = loan_versions.executed_interest_rate_type_id
	LEFT JOIN currencies ON currencies.fund_id = funds.id AND currencies.id = loan_versions.currency_id
	LEFT JOIN currency_rates ON currency_rates.currency_id = currencies.id
	LEFT JOIN repayment_types ON repayment_types.fund_id = funds.id AND repayment_types.id = loan_versions.repayment_type_id
	LEFT JOIN bonds ON bonds.fund_id = funds.id AND bonds.id = loan_versions.executed_bond_id
	LEFT JOIN pools ON pools.fund_id = funds.id AND pools.id = loan_versions.pool_id
	LEFT JOIN im_groups ON im_groups.fund_id = funds.id AND loans.im_group_id = im_groups.id
	LEFT JOIN institutions ON institutions.fund_id = funds.id AND institutions.id = loans.institution_id
	LEFT JOIN institution_groups ON institution_groups.fund_id = funds.id AND institution_groups.id = institutions.institution_group_id
	LEFT JOIN countries ON countries.fund_id = funds.id AND countries.id = institutions.country_id
	LEFT JOIN country_groups ON country_groups.fund_id = funds.id AND country_groups.id = countries.country_group_id
	LEFT JOIN institution_types ON institution_types.fund_id = funds.id AND institution_types.id = institutions.institution_type_id
	LEFT JOIN (SELECT max(id) as max_id, loan_id FROM loan_sdg_data WHERE deleted_at IS NULL GROUP BY loan_id) max_sdg_data ON max_sdg_data.loan_id = loans.id
	LEFT JOIN loan_sdg_data ON loan_sdg_data.loan_id = loans.id AND loan_sdg_data.id = max_sdg_data.max_id
	LEFT JOIN (SELECT max(id) as max_id, loan_id FROM presentation_compliance_checks WHERE deleted_at IS NULL GROUP BY loan_id) max_presentation_compliance_checks ON max_presentation_compliance_checks.loan_id = loans.id
	LEFT JOIN presentation_compliance_checks ON presentation_compliance_checks.loan_id = loans.id AND presentation_compliance_checks.id = max_presentation_compliance_checks.max_id
WHERE
	currency_rates.expired_date IS NULL
	AND loan_versions.deleted_at IS NULL
	AND loan_types.deleted_at IS NULL
	AND interest_rate_types.deleted_at IS NULL
	AND currencies.deleted_at IS NULL
	AND currency_rates.deleted_at IS NULL
	AND repayment_types.deleted_at IS NULL
	AND bonds.deleted_at IS NULL
	AND pools.deleted_at IS NULL
	AND institutions.deleted_at IS NULL
	AND institution_groups.deleted_at IS NULL
	AND countries.deleted_at IS NULL
	AND country_groups.deleted_at IS NULL
	AND institution_types.deleted_at IS NULL
	AND presentation_compliance_checks.deleted_at IS NULL
	AND loan_sdg_data.deleted_at IS NULL
    AND loan_versions.version_number = loans.last_loan_version;
