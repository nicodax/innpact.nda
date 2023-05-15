SELECT 
	loans.innpact_loan_id,
	im_groups.name AS im_group,
	pools.name AS pool,
	loans.noval,
	loan_versions.status AS status,
	institutions.name AS institutions,
	institution_groups.name AS institution_group,
	countries.name AS country_name,
	country_groups.name AS region_name,
	currencies.short_name AS local_ccy,
	CASE
		WHEN (loan_versions.status = 'assigned' AND expected_disbursement_date >= nav_date)
			THEN loan_versions.expected_disbursement_date
		WHEN (loan_versions.status = 'ratified' AND expected_disbursement_date >= nav_date)
			THEN loan_versions.expected_disbursement_date
		WHEN (loan_versions.status = 'approved' AND expected_disbursement_date >= nav_date)
			THEN loan_versions.expected_disbursement_date
		WHEN (loan_versions.status = 'invested' AND repayment_types.name = 'bullet' AND loan_versions.maturity_date >= nav_date)
			THEN loan_versions.maturity_date
		WHEN (loan_versions.status = 'invested' AND repayment_types.name = 'amortization' AND repayment_date >= nav_date)
			THEN repayment_calendar_lines.repayment_date
		WHEN (loan_versions.status = 'matured' AND repayment_types.name = 'bullet' AND loan_versions.maturity_date >= nav_date AND loan_versions.maturity_date <= GETDATE())
			THEN loan_versions.maturity_date
		WHEN (loan_versions.status = 'matured' AND repayment_types.name = 'amortization' AND repayment_date >= nav_date)
			THEN repayment_calendar_lines.repayment_date
	END AS repayment_date,
	CASE
		WHEN (loan_versions.status = 'assigned' AND expected_disbursement_date >= nav_date)
			THEN loan_versions.proposed_nominal_amount / currency_rates.rate
		WHEN (loan_versions.status = 'ratified' AND expected_disbursement_date >= nav_date)
			THEN loan_versions.ratified_nominal_amount / currency_rates.rate
		WHEN (loan_versions.status = 'approved' AND expected_disbursement_date >= nav_date)
			THEN loan_versions.approved_nominal_amount / currency_rates.rate
		WHEN (loan_versions.status = 'invested' AND repayment_types.name = 'bullet' AND loan_versions.maturity_date >= nav_date)
			THEN loan_versions.executed_nominal_amount * (-1) / currency_rates.rate
		WHEN (loan_versions.status = 'invested' AND repayment_types.name = 'amortization' AND repayment_date >= nav_date)
			THEN repayment_calendar_lines.original_amount * (-1) / currency_rates.rate
		WHEN (loan_versions.status = 'matured' AND repayment_types.name = 'bullet' AND loan_versions.maturity_date >= nav_date AND loan_versions.maturity_date <= GETDATE())
			THEN loan_versions.executed_nominal_amount * (-1) / currency_rates.rate
		WHEN (loan_versions.status = 'matured' AND repayment_types.name = 'amortization' AND repayment_date >= nav_date)
			THEN repayment_calendar_lines.original_amount * (-1) / currency_rates.rate
	END AS amount_usd,
	CASE
		WHEN (loan_versions.status = 'assigned' AND expected_disbursement_date >= nav_date)
			THEN 'Expected disbursement'
		WHEN (loan_versions.status = 'ratified' AND expected_disbursement_date >= nav_date)
			THEN 'Expected disbursement'
		WHEN (loan_versions.status = 'approved' AND expected_disbursement_date >= nav_date)
			THEN 'Expected disbursement'
		WHEN (loan_versions.status = 'invested' AND repayment_types.name = 'bullet' AND loan_versions.maturity_date >= nav_date)
			THEN 'Maturity date'
		WHEN (loan_versions.status = 'invested' AND repayment_types.name = 'amortization' AND repayment_date >= nav_date)
			THEN 'Amortization'
		WHEN (loan_versions.status = 'matured' AND repayment_types.name = 'bullet' AND loan_versions.maturity_date >= nav_date AND loan_versions.maturity_date <= GETDATE())
			THEN 'Bullet matured'
		WHEN (loan_versions.status = 'matured' AND repayment_types.name = 'amortization' AND repayment_date >= nav_date)
			THEN 'Amortization'
	END AS type,
	loan_versions.nav_date,
	loan_versions.net_position_value,
	CASE
		WHEN (loan_versions.status = 'assigned' AND expected_disbursement_date >= nav_date)
			THEN loan_versions.proposed_nominal_amount
		WHEN (loan_versions.status = 'ratified' AND expected_disbursement_date >= nav_date)
			THEN loan_versions.ratified_nominal_amount
		WHEN (loan_versions.status = 'approved' AND expected_disbursement_date >= nav_date)
			THEN loan_versions.approved_nominal_amount
		WHEN (loan_versions.status = 'invested' AND repayment_types.name = 'bullet' AND loan_versions.maturity_date >= nav_date)
			THEN loan_versions.executed_nominal_amount * (-1)
		WHEN (loan_versions.status = 'invested' AND repayment_types.name = 'amortization' AND repayment_date >= nav_date)
			THEN repayment_calendar_lines.original_amount * (-1)
		WHEN (loan_versions.status = 'matured' AND repayment_types.name = 'bullet' AND loan_versions.maturity_date >= nav_date AND loan_versions.maturity_date <= GETDATE())
			THEN loan_versions.executed_nominal_amount * (-1)
		WHEN (loan_versions.status = 'matured' AND repayment_types.name = 'amortization' AND repayment_date >= nav_date)
			THEN repayment_calendar_lines.original_amount * (-1)
	END AS amount_value_local_ccy,
	repayment_calendar_lines.received_amount As received_amount_ccy,
	repayment_calendar_lines.received_amount / currency_rates.rate As received_amount_usd,
	GETDATE() As data_viewed_at
	
     FROM loans
        LEFT JOIN funds ON loans.fund_id = funds.id
		LEFT JOIN loan_versions ON loan_versions.loan_id = loans.id
		LEFT JOIN repayment_calendars ON repayment_calendars.loan_version_id = loan_versions.id
		LEFT JOIN repayment_calendar_lines ON repayment_calendar_lines.repayment_calendar_id = repayment_calendars.id
		LEFT JOIN currencies ON currencies.fund_id = funds.id
		AND currencies.id = loan_versions.currency_id
		LEFT JOIN currency_rates ON currency_rates.currency_id = currencies.id
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
		LEFT JOIN repayment_types ON repayment_types.fund_id = funds.id
		AND repayment_types.id = loan_versions.repayment_type_id
		
	WHERE 
		currency_rates.expired_date IS NULL
		AND (
			(loan_versions.status = 'assigned' AND expected_disbursement_date >= nav_date)
			OR (loan_versions.status = 'ratified' AND expected_disbursement_date >= nav_date)
			OR (loan_versions.status = 'approved' AND expected_disbursement_date >= nav_date)
			OR (loan_versions.status = 'invested' AND repayment_types.name = 'bullet' AND loan_versions.maturity_date >= nav_date)
			OR (loan_versions.status = 'invested' AND repayment_types.name = 'amortization' AND repayment_date >= nav_date)
			OR (loan_versions.status = 'matured' AND repayment_types.name = 'bullet' AND loan_versions.maturity_date >= nav_date AND loan_versions.maturity_date <= GETDATE())
			OR (loan_versions.status = 'matured' AND repayment_types.name = 'amortization' AND repayment_date >= nav_date)
		)
		AND loan_versions.deleted_at IS NULL
		AND repayment_calendars.deleted_at IS NULL
		AND repayment_calendar_lines.deleted_at IS NULL
		AND repayment_calendars.deleted_at IS NULL
		AND currencies.deleted_at IS NULL
		AND currency_rates.deleted_at IS NULL
		AND pools.deleted_at IS NULL
		AND institutions.deleted_at IS NULL
		AND institution_groups.deleted_at IS NULL
		AND countries.deleted_at IS NULL
		AND country_groups.deleted_at IS NULL
		AND repayment_types.deleted_at IS NULL
		AND loan_versions.version_number = loans.last_loan_version