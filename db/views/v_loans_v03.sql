SELECT 
            loan_versions.*,
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

			loan_provisions.amount AS loan_provisions_amount,
			loan_provisions.percentage AS loan_provisions_amount_percentage,
			loan_provisions.new_amount_of_provision,
			loan_provisions.previous_amount_of_provision,
			loan_provisions.institution_provision_id,

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

			GETDATE() As data_viewed_at		

     FROM loans
        LEFT JOIN funds ON loans.fund_id = funds.id
		LEFT JOIN loan_versions ON loan_versions.loan_id = loans.id
		LEFT JOIN loan_types ON funds.id = loan_types.fund_id
		AND loan_types.id = loan_versions.loan_type_id
		LEFT JOIN interest_rate_types ON interest_rate_types.fund_id = funds.id
		AND interest_rate_types.id = loan_versions.interest_rate_type_id
		LEFT JOIN loan_provisions ON loans.id = loan_provisions.loan_id
		LEFT JOIN repayment_calendars ON repayment_calendars.loan_version_id = loan_versions.id
		LEFT JOIN currencies ON currencies.fund_id = funds.id
		AND currencies.id = loan_versions.currency_id
		LEFT JOIN currency_rates ON currency_rates.currency_id = currencies.id
		LEFT JOIN repayment_types ON repayment_types.fund_id = funds.id
		AND repayment_types.id = loan_versions.repayment_type_id
		LEFT JOIN bonds ON bonds.fund_id = funds.id
		AND bonds.id = loan_versions.bond_id
		LEFT JOIN pools ON pools.fund_id = funds.id
		AND pools.id = loan_versions.pool_id
		LEFT JOIN im_groups ON im_groups.fund_id = funds.id
		AND loans.im_group_id = im_groups.id
		LEFT JOIN institutions ON institutions.fund_id = funds.id
		AND institutions.id = loans.institution_id
		LEFT JOIN institution_groups ON institution_groups.fund_id = funds.id
		AND institution_groups.id = institutions.institution_group_id
		LEFT JOIN countries ON countries.fund_id = funds.id
		AND countries.id = institutions.country_id
		LEFT JOIN country_groups ON country_groups.fund_id = funds.id
		AND country_groups.id = countries.country_group_id
		LEFT JOIN institution_types ON institution_types.fund_id = funds.id
		AND institution_types.id = institutions.institution_type_id
	WHERE 
		currency_rates.expired_date IS NULL