WITH max_ratings_as_of AS (
    SELECT institution_id, MAX(as_of) AS max_as_of
    FROM institution_ratings
    WHERE deleted_at IS NULL
    GROUP BY institution_id
),
max_ratings AS (
    SELECT institution_ratings.institution_id, institution_ratings.as_of AS max_as_of, MAX(institution_ratings.updated_at) AS max_updated_at
    FROM institution_ratings
		JOIN max_ratings_as_of ON max_ratings_as_of.max_as_of = institution_ratings.as_of
    WHERE deleted_at IS NULL
    GROUP BY institution_ratings.institution_id, institution_ratings.as_of
),
max_financials_as_of AS (
    SELECT institution_id, MAX(as_of) AS max_as_of
    FROM institution_financials
    WHERE deleted_at IS NULL
    GROUP BY institution_id
),
max_financials AS (
    SELECT institution_financials.institution_id, institution_financials.as_of AS max_as_of, MAX(institution_financials.updated_at) AS max_updated_at
    FROM institution_financials
		JOIN max_financials_as_of ON max_financials_as_of.max_as_of = institution_financials.as_of
    WHERE deleted_at IS NULL
    GROUP BY institution_financials.institution_id, institution_financials.as_of
),
max_specific_breakdowns_as_of AS (
	SELECT institution_id, MAX(as_of) AS max_as_of
    FROM institution_specific_breakdowns
    WHERE deleted_at IS NULL
    GROUP BY institution_id
),
max_specific_breakdowns AS (
    SELECT institution_specific_breakdowns.institution_id, institution_specific_breakdowns.as_of AS max_as_of, MAX(institution_specific_breakdowns.updated_at) AS max_updated_at
    FROM institution_specific_breakdowns
		JOIN max_specific_breakdowns_as_of ON max_specific_breakdowns_as_of.max_as_of = institution_specific_breakdowns.as_of
    WHERE deleted_at IS NULL
    GROUP BY institution_specific_breakdowns.institution_id, institution_specific_breakdowns.as_of
),
max_impact_indicators_as_of AS (
    SELECT institution_id, MAX(as_of) AS max_as_of
    FROM institution_impact_indicators
    WHERE deleted_at IS NULL
    GROUP BY institution_id
),
max_impact_indicators AS (
    SELECT institution_impact_indicators.institution_id, institution_impact_indicators.as_of AS max_as_of, MAX(institution_impact_indicators.updated_at) AS max_updated_at
    FROM institution_impact_indicators
		JOIN max_impact_indicators_as_of ON max_impact_indicators_as_of.max_as_of = institution_impact_indicators.as_of
    WHERE deleted_at IS NULL
    GROUP BY institution_impact_indicators.institution_id, institution_impact_indicators.as_of
),
max_positive_impact_services_offereds_as_of AS (
    SELECT institution_id, MAX(as_of) AS max_as_of
    FROM positive_impact_services_offereds
    WHERE deleted_at IS NULL
    GROUP BY institution_id
),
max_positive_impact_services_offereds AS (
    SELECT positive_impact_services_offereds.institution_id, positive_impact_services_offereds.as_of AS max_as_of, MAX(positive_impact_services_offereds.updated_at) AS max_updated_at
    FROM positive_impact_services_offereds
		JOIN max_positive_impact_services_offereds_as_of ON max_positive_impact_services_offereds_as_of.max_as_of = positive_impact_services_offereds.as_of
    WHERE deleted_at IS NULL
    GROUP BY positive_impact_services_offereds.institution_id, positive_impact_services_offereds.as_of
),
max_institution_esg_gender_equalities_as_of AS (
    SELECT institution_id, MAX(as_of) AS max_as_of
    FROM institution_esg_gender_equalities
    WHERE deleted_at IS NULL
    GROUP BY institution_id
),
max_institution_esg_gender_equalities AS (
    SELECT institution_esg_gender_equalities.institution_id, institution_esg_gender_equalities.as_of AS max_as_of, MAX(institution_esg_gender_equalities.updated_at) AS max_updated_at
    FROM institution_esg_gender_equalities
		JOIN max_institution_esg_gender_equalities_as_of ON max_institution_esg_gender_equalities_as_of.max_as_of = institution_esg_gender_equalities.as_of
    WHERE deleted_at IS NULL
    GROUP BY institution_esg_gender_equalities.institution_id, institution_esg_gender_equalities.as_of
),
max_institution_alinus_results_as_of AS (
    SELECT institution_id, MAX(as_of) AS max_as_of
    FROM institution_alinus_results
    WHERE deleted_at IS NULL
    GROUP BY institution_id
),
max_institution_alinus_results AS (
    SELECT institution_alinus_results.institution_id, institution_alinus_results.as_of AS max_as_of, MAX(institution_alinus_results.updated_at) AS max_updated_at
    FROM institution_alinus_results
		JOIN max_institution_alinus_results_as_of ON max_institution_alinus_results_as_of.max_as_of = institution_alinus_results.as_of
    WHERE deleted_at IS NULL
    GROUP BY institution_alinus_results.institution_id, institution_alinus_results.as_of
),
max_institution_esg_risks_as_of AS (
    SELECT institution_id, MAX(as_of) AS max_as_of
    FROM institution_esg_risks
    WHERE deleted_at IS NULL
    GROUP BY institution_id
),
max_institution_esg_risks AS (
    SELECT institution_esg_risks.institution_id, institution_esg_risks.as_of AS max_as_of, MAX(institution_esg_risks.updated_at) AS max_updated_at
    FROM institution_esg_risks
		JOIN max_institution_esg_risks_as_of ON max_institution_esg_risks_as_of.max_as_of = institution_esg_risks.as_of
    WHERE deleted_at IS NULL
    GROUP BY institution_esg_risks.institution_id, institution_esg_risks.as_of
),
max_institution_esg_safeguards_as_of AS (
    SELECT institution_id, MAX(as_of) AS max_as_of
    FROM institution_esg_safeguards
    WHERE deleted_at IS NULL
    GROUP BY institution_id
),
max_institution_esg_safeguards AS (
    SELECT institution_esg_safeguards.institution_id, institution_esg_safeguards.as_of AS max_as_of, MAX(institution_esg_safeguards.updated_at) AS max_updated_at
    FROM institution_esg_safeguards
		JOIN max_institution_esg_safeguards_as_of ON max_institution_esg_safeguards_as_of.max_as_of = institution_esg_safeguards.as_of
    WHERE deleted_at IS NULL
    GROUP BY institution_esg_safeguards.institution_id, institution_esg_safeguards.as_of
),
max_institution_esg_pai_indicators_as_of AS (
    SELECT institution_id, MAX(as_of) AS max_as_of
    FROM institution_esg_pai_indicators
    WHERE deleted_at IS NULL
    GROUP BY institution_id
),
max_institution_esg_pai_indicators AS (
    SELECT institution_esg_pai_indicators.institution_id, institution_esg_pai_indicators.as_of AS max_as_of, MAX(institution_esg_pai_indicators.updated_at) AS max_updated_at
    FROM institution_esg_pai_indicators
		JOIN max_institution_esg_pai_indicators_as_of ON max_institution_esg_pai_indicators_as_of.max_as_of = institution_esg_pai_indicators.as_of
    WHERE deleted_at IS NULL
    GROUP BY institution_esg_pai_indicators.institution_id, institution_esg_pai_indicators.as_of
)

SELECT 

		institutions.name,
		im_groups.name As assigned_IM_group,
		countries.name AS country,
		institution_groups.name AS institution_group,
		institution_types.name AS institution_type,
		institutions.tier,
		institutions.regulatory_status,
		institutions.cpps_adoption,
		institutions.use_of_standard_reporting_tools AS use_of_standard_reporting_tools_sptf_alinus,

		/* institution_rating  */
		institution_ratings.as_of AS rating_as_of,
		institution_ratings.internal_credit_risk_rating,
		institution_ratings.external_rating AS external_rating,
		institution_ratings.external_rating_agency AS external_rating_agency,
		institution_ratings.probability_of_default,

		/* institution_financials */
		institution_financials.as_of AS financials_time_stamp,
		institution_financials.total_assets,
		institution_financials.gross_loan_portfolio,
		institution_financials.provision_for_loss,
		institution_financials.international_liabilities,
		institution_financials.domestic_liabilities,
		institution_financials.deposit_amount,
		institution_financials.liabilities,
		institution_financials.equity,
		institution_financials.revenues,
		institution_financials.net_income,
		institution_financials.net_income_distributed_as_dividends,
		institution_financials.npls AS npls_USD,
		institution_financials.write_off AS write_off_USD,

		/* institution_specific_breakdowns */
		/* MEF-Specific */
		institution_specific_breakdowns.as_of AS institution_specific_breakdowns_as_of,
		institution_specific_breakdowns.microfinance_portfolio_size,
		institution_specific_breakdowns.sme_portfolio_size_under_35k,
		institution_specific_breakdowns.sme_portfolio_size_under_50k,
		institution_specific_breakdowns.percentage_loans_to_rural_borrowers_per_glp AS percentage_rural_ptf,

		/* Distribution By Sector */
		institution_specific_breakdowns.trade_and_services AS sector_trade_and_services_percent,
		institution_specific_breakdowns.agriculture AS agriculture_percent,
		institution_specific_breakdowns.production AS production_percent,
		institution_specific_breakdowns.consumption AS consumption_percent,
		institution_specific_breakdowns.by_sector_other AS by_sector_other_percent,

		/* Distribution By Loan Purpose */
		institution_specific_breakdowns.microenterprise AS loan_purpose_microenterprise_percent,
		institution_specific_breakdowns.sme AS loan_purpose_sme_percent,
		institution_specific_breakdowns.corporate AS loan_purpose_corporate_percent,
		institution_specific_breakdowns.housing AS loan_purpose_housing_percent,
		institution_specific_breakdowns.personal AS loan_purpose_personal_percent,
		institution_specific_breakdowns.by_loan_purpose_other AS loan_purpose_other_percent,


		/* institution_impact_indicators */
		institution_impact_indicators.as_of AS impact_indicator_as_of_date,
		institution_impact_indicators.internal_impact_score,
		institution_impact_indicators.avg_loan_size AS average_loan_size,
		institution_impact_indicators.number_of_clients,
		institution_impact_indicators.borrowers_count AS number_active_borrowers,
		institution_impact_indicators.female_borrowers_count AS number_female_borrowers,
		institution_impact_indicators.rural_borrowers_count AS number_rural_borrowers,
		institution_impact_indicators.number_of_sme_borrowers AS number_sme_borrowers,
		institution_impact_indicators.number_of_micro_borrowers AS number_micro_borrowers,

		/* positive_impact_services_offereds */
		positive_impact_services_offereds.as_of AS services_offered_as_of_date,
		positive_impact_services_offereds.mobile_banking_services,
		positive_impact_services_offereds.number_clients_using_mobile_banking,
		positive_impact_services_offereds.deposits,
        positive_impact_services_offereds.number_clients_with_deposits,
        positive_impact_services_offereds.voluntary_savings,

		/* positive_impact_services_offereds */
		institution_esg_gender_equalities.as_of AS esg_gender_equalities_as_of_date,
		institution_esg_gender_equalities.percentage_loans_to_women_borrowers_per_glp AS percentage_of_women_ptf,
		institution_esg_gender_equalities.women_percentage_in_board,
		institution_esg_gender_equalities.women_percentage_in_management,
		institution_esg_gender_equalities.women_percentage_in_staff,
		institution_esg_gender_equalities.percentage_women_among_loan_officers,
		institution_esg_gender_equalities.financial_services_targeting_women,
		institution_esg_gender_equalities.non_financial_services_targeting_women,
		institution_esg_gender_equalities.training_on_responsible_finance_targeting_women,

		/* institution_alinus_results */
		institution_alinus_results.as_of AS aptf_alinus_results_time_stamp,
		institution_alinus_results.overall_sptf_alinus_score,
		institution_alinus_results.define_and_monitor_social_goals,
		institution_alinus_results.ensure_commitment_to_social_goals,
		institution_alinus_results.product_design_to_meet_clients_need,
		institution_alinus_results.treat_clients_responsibly,
		institution_alinus_results.treat_employees_responsibly,
		institution_alinus_results.balance_financial_and_performance,
		institution_alinus_results.promote_environmental_protection,
 
		/* institution_esg_risks */
		institution_esg_risks.as_of AS esg_risk_as_of,
		institution_esg_risks.tool_use_for_esg_score,
		institution_esg_risks.internal_esg_score,
		institution_esg_risks.ifc_esg_risk_financial_intermediaries_classification,
		institution_esg_risks.esms_in_place_commensurate_with_risk_profile,

		/* institution_esg_safeguards */
		institution_esg_safeguards.as_of AS esg_safeguards_as_of,
		institution_esg_safeguards.compliance_with_fund_exclusion_list,
		institution_esg_safeguards.compliance_with_international_labour_organization_standards,
		institution_esg_safeguards.compliance_with_international_bill_of_human_rights,
		institution_esg_safeguards.compliance_with_guiding_principles_on_business_and_human_rights,
		institution_esg_safeguards.compliance_with_oecd_guidelines_for_multinational_enterprises,
		institution_esg_safeguards.compliance_with_national_standards_and_law,
		institution_esg_safeguards.compliance_with_client_protection_principles,
 
		/* institution_esg_pai_indicators */
		institution_esg_pai_indicators.as_of AS pai_indicator_as_of,
		institution_esg_pai_indicators.scope_1_emissions,
		institution_esg_pai_indicators.scope_2_emissions,
		institution_esg_pai_indicators.scope_3_emissions,
		institution_esg_pai_indicators.carbon_footprint,
		institution_esg_pai_indicators.ghg_intensity_investee_companies,
		institution_esg_pai_indicators.exposure_companies_active_in_fossil_fuel_sector,
		institution_esg_pai_indicators.share_of_non_renewable_energy_consumption_and_production,
		institution_esg_pai_indicators.energy_consumption_intensity_per_high_impact_climate_sector,
		institution_esg_pai_indicators.activities_negatively_affecting_biodiversity_sensitive_areas,
		institution_esg_pai_indicators.emissions_to_water,
		institution_esg_pai_indicators.hazardous_waste_ratio,
		institution_esg_pai_indicators.violations_of_un_global_compact_principles_and_oecd_guidelines_for_multinational_enterprises,
		institution_esg_pai_indicators.lack_of_processes_and_compliance_mechanisms_to_monitor_compliance_with_un_global_compact_principles,
		institution_esg_pai_indicators.unadjusted_gender_pay_gap,
		institution_esg_pai_indicators.board_gender_diversity,
		institution_esg_pai_indicators.exposure_to_controversial_weapons,
		
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
	
		/* institution_ratings */
		LEFT JOIN max_ratings ON max_ratings.institution_id = institutions.id
		LEFT JOIN institution_ratings ON institution_ratings.institution_id = max_ratings.institution_id  
		AND institution_ratings.as_of = max_ratings.max_as_of
		AND institution_ratings.updated_at = max_ratings.max_updated_at
		
		/* institution_financials */
		LEFT JOIN max_financials ON max_financials.institution_id = institutions.id
		LEFT JOIN institution_financials ON institution_financials.institution_id = max_financials.institution_id  
		AND institution_financials.as_of = max_financials.max_as_of
		AND institution_financials.updated_at = max_financials.max_updated_at

		/* institution_specific_breakdowns */
		LEFT JOIN max_specific_breakdowns ON max_specific_breakdowns.institution_id = institutions.id
		LEFT JOIN institution_specific_breakdowns ON institution_specific_breakdowns.institution_id = max_specific_breakdowns.institution_id  
		AND institution_specific_breakdowns.as_of = max_specific_breakdowns.max_as_of
		AND institution_specific_breakdowns.updated_at = max_specific_breakdowns.max_updated_at

		/* institution_impact_indicators */
		LEFT JOIN max_impact_indicators ON max_impact_indicators.institution_id = institutions.id
		LEFT JOIN institution_impact_indicators ON institution_impact_indicators.institution_id = max_impact_indicators.institution_id  
		AND institution_impact_indicators.as_of = max_impact_indicators.max_as_of
		AND institution_impact_indicators.updated_at = max_impact_indicators.max_updated_at

		/* positive_impact_services_offereds */
		LEFT JOIN max_positive_impact_services_offereds ON max_positive_impact_services_offereds.institution_id = institutions.id
		LEFT JOIN positive_impact_services_offereds ON positive_impact_services_offereds.institution_id = max_positive_impact_services_offereds.institution_id  
		AND positive_impact_services_offereds.as_of = max_positive_impact_services_offereds.max_as_of
		AND positive_impact_services_offereds.updated_at = max_positive_impact_services_offereds.max_updated_at

		/* institution_esg_gender_equalities */
		LEFT JOIN max_institution_esg_gender_equalities ON max_institution_esg_gender_equalities.institution_id = institutions.id
		LEFT JOIN institution_esg_gender_equalities ON institution_esg_gender_equalities.institution_id = max_institution_esg_gender_equalities.institution_id  
		AND institution_esg_gender_equalities.as_of = max_institution_esg_gender_equalities.max_as_of
		AND institution_esg_gender_equalities.updated_at = max_institution_esg_gender_equalities.max_updated_at

		/* institution_alinus_results */
		LEFT JOIN max_institution_alinus_results ON max_institution_alinus_results.institution_id = institutions.id
		LEFT JOIN institution_alinus_results ON institution_alinus_results.institution_id = max_institution_alinus_results.institution_id  
		AND institution_alinus_results.as_of = max_institution_alinus_results.max_as_of
		AND institution_alinus_results.updated_at = max_institution_alinus_results.max_updated_at

		/* institution_esg_risks */
		LEFT JOIN max_institution_esg_risks ON max_institution_esg_risks.institution_id = institutions.id
		LEFT JOIN institution_esg_risks ON institution_esg_risks.institution_id = institutions.id  
		AND institution_esg_risks.as_of = max_institution_esg_risks.max_as_of
		AND institution_esg_risks.updated_at = max_institution_esg_risks.max_updated_at

		/* institution_esg_safeguards */
		LEFT JOIN max_institution_esg_safeguards ON max_institution_esg_safeguards.institution_id = institutions.id
		LEFT JOIN institution_esg_safeguards ON institution_esg_safeguards.institution_id = max_institution_esg_safeguards.institution_id  
		AND institution_esg_safeguards.as_of = max_institution_esg_safeguards.max_as_of
		AND institution_esg_safeguards.updated_at = max_institution_esg_safeguards.max_updated_at

		/* institution_esg_pai_indicators */
		LEFT JOIN max_institution_esg_pai_indicators ON max_institution_esg_pai_indicators.institution_id = institutions.id
		LEFT JOIN institution_esg_pai_indicators ON institution_esg_pai_indicators.institution_id = max_institution_esg_pai_indicators.institution_id  
		AND institution_esg_pai_indicators.as_of = max_institution_esg_pai_indicators.max_as_of
		AND institution_esg_pai_indicators.updated_at = max_institution_esg_pai_indicators.max_updated_at

	WHERE 
	institutions.deleted_at IS NULL
