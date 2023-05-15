SELECT 
		institutions.name As institution_name,
		im_groups.name As iM_group,
		institution_covenants.par30,
		institution_covenants.par30_limit,
		institution_covenants.par30_refy,
		institution_covenants.par30_refy_limit,
		institution_covenants.roa,
		institution_covenants.roa_limit,
		institution_covenants.adj_roa,
		institution_covenants.adj_roa_limit,
		institution_covenants.open_fx_exposure,
		institution_covenants.open_fx_exposure_limit,
		institution_covenants.open_loan_position,
		institution_covenants.open_loan_position_limit,
		institution_covenants.car,
		institution_covenants.car_limit,
		institution_covenants.deposits_liabilities,
		institution_covenants.deposits_liabilities_limit,
		institution_covenants.maturity_matching_if_applicable,
		institution_covenants.maturity_matching_if_applicable_limit,
		institution_covenants.liquid_assets_deposits_if_applicable,
		institution_covenants.liquid_assets_deposits_if_applicable_limit,
		GETDATE() As data_viewed_at

     FROM institution_covenants
		LEFT JOIN funds ON institution_covenants.fund_id = funds.id
		LEFT JOIN institutions ON institutions.fund_id = funds.id
		AND institutions.id = institution_covenants.institution_id
		LEFT JOIN im_groups ON im_groups.fund_id = funds.id
		AND institutions.id = institution_covenants.institution_id
		AND im_groups.id = institutions.im_group_id
	
	WHERE 
		institution_covenants.deleted_at IS NULL
		AND institutions.deleted_at IS NULL
		AND institution_covenants.deleted_at IS NULL