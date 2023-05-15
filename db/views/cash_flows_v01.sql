SELECT 
			loans.innpact_loan_id,
			im_groups.name AS IM_Group,
			pools.name AS pool,
			loans.noval,
			loan_versions.status AS status,
			institutions.name AS Institutions,
			institution_groups.name AS Institution_group,
			countries.name AS Country,
			country_groups.name AS Region,
			currencies.short_name AS Local_Currency,
			repayment_calendar_lines.repayment_date,
			repayment_calendar_lines.repayment_type AS calendar_repayment_type,
			repayment_types.name AS loan_repayment_type,
			loan_versions.net_position_value,
			repayment_calendar_lines.original_amount AS original_amount_local_CCY,
			repayment_calendar_lines.original_amount / currency_rates.rate AS original_amount_USD,
			ABS(original_amount) AS ABS_original_amount,
			repayment_calendar_lines.received_amount AS Received_amount_CCY,
			repayment_calendar_lines.received_amount / currency_rates.rate AS Received_amount_USD

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
		(loan_versions.status = 'assigned')
		OR (loan_versions.status = 'ratified')
		OR (loan_versions.status = 'approved')
		OR (loan_versions.status = 'invested' AND repayment_types.name = 'bullet')
		OR (loan_versions.status = 'invested' AND repayment_types.name = 'amortization')
		OR (loan_versions.status = 'matured' AND repayment_types.name = 'bullet')
		OR (loan_versions.status = 'matured' AND repayment_types.name = 'amortization' AND loan_versions.maturity_date <= GETDATE())
		)