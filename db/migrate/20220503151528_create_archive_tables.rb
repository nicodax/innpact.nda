class CreateArchiveTables < ActiveRecord::Migration[6.0]
  def change
    create_table :archive_cash_flows, if_not_exists: true do |t|
      t.integer "innpact_loan_id", null: false
      t.string "im_group"
      t.string "pool"
      t.integer "noval"
      t.string "status"
      t.string "institutions"
      t.string "institution_group"
      t.string "country_name"
      t.string "region_name"
      t.string "local_ccy"
      t.date "repayment_date"
      t.decimal "amount_usd", precision: 38, scale: 15
      t.varchar "type", limit: 21
      t.date "nav_date"
      t.decimal "net_position_value", precision: 17, scale: 2
      t.decimal "amount_value_local_ccy", precision: 19, scale: 2
      t.decimal "received_amount_ccy", precision: 17, scale: 2
      t.decimal "received_amount_usd", precision: 38, scale: 17
      t.datetime "data_viewed_at", null: false
    end

    create_table :archive_v_institutions, if_not_exists: true do |t|
      t.date "general_time_stamp"
      t.string "name"
      t.string "assigned_IM_group"
      t.string "country"
      t.string "institution_group"
      t.string "institution_type"
      t.integer "ia_esg_rating"
      t.string "internal_rating"
      t.string "external_rating_moody"
      t.integer "tier"
      t.boolean "environmental_rating"
      t.string "cpps_adoption"
      t.string "kyc_check"
      t.boolean "use_of_standard_reporting_tools"
      t.boolean "involvement_in_responsible_finance_initiatives"
      t.boolean "training_on_responsible_finance_targeting_women"
      t.boolean "provision_of_financial_products_targeting_enterprise_set_up"
      t.date "financials_time_stamp"
      t.decimal "total_assets", precision: 18, scale: 2
      t.decimal "equity", precision: 18, scale: 2
      t.decimal "liabilities", precision: 18, scale: 2
      t.decimal "domestic_liabilities", precision: 18, scale: 2
      t.decimal "international_liabilities", precision: 18, scale: 2
      t.decimal "other_liabilities", precision: 18, scale: 2
      t.decimal "revenues", precision: 18, scale: 2
      t.decimal "net_income", precision: 18, scale: 2
      t.decimal "net_income_distributed_as_dividends", precision: 17, scale: 2
      t.decimal "provision_for_loss", precision: 18, scale: 2
      t.decimal "write_off", precision: 18, scale: 2
      t.boolean "deposits"
      t.decimal "deposit_amount", precision: 18, scale: 2
      t.boolean "saving"
      t.decimal "saving_amount", precision: 18, scale: 2
      t.boolean "mobile_banking_services"
      t.string "list_dfi_lenders"
      t.string "financial_strength_of_shareholders", limit: 50
      t.date "clients_as_of_date"
      t.bigint "number_active_borrowers"
      t.bigint "number_female_borrowers"
      t.bigint "number_rural_borrowers"
      t.bigint "number_micro_borrowers"
      t.bigint "number_sme_borrowers"
      t.decimal "average_loan_size", precision: 18, scale: 2
      t.date "portfolio_breakdown_I_time_stamp"
      t.decimal "gross_loan_portfolio", precision: 18, scale: 2
      t.decimal "portfolio_3y_ago", precision: 18, scale: 2
      t.decimal "microfinance_portfolio_size", precision: 18, scale: 2
      t.decimal "sme_portfolio_size", precision: 18, scale: 2
      t.date "portfolio_breakdown_II_distribution_by_sector_time_stamp"
      t.decimal "trade", precision: 17, scale: 2
      t.decimal "services", precision: 17, scale: 2
      t.decimal "agriculture", precision: 17, scale: 2
      t.decimal "production", precision: 17, scale: 2
      t.decimal "education", precision: 17, scale: 2
      t.decimal "housing", precision: 17, scale: 2
      t.decimal "consumption", precision: 17, scale: 2
      t.decimal "other", precision: 17, scale: 2
      t.date "portfolio_breakdown_III_distribution_by_loan_time_stamp"
      t.decimal "microenterprise_usd", precision: 18, scale: 2
      t.decimal "sme_usd", precision: 18, scale: 2
      t.decimal "corporate_usd", precision: 18, scale: 2
      t.decimal "housing_usd", precision: 18, scale: 2
      t.decimal "personal_usd", precision: 18, scale: 2
      t.decimal "other_usd", precision: 18, scale: 2
      t.date "aptf_alinus_results_time_stamp"
      t.boolean "has_sptf_alinus_reporting_using_alinus"
      t.string "sptf_alinus_reporting_using_alinus", limit: 15
      t.decimal "overall_sptf_alinus_score", precision: 5, scale: 2
      t.decimal "define_and_monitor_social_goals", precision: 5, scale: 2
      t.decimal "ensure_commitment_to_social_goals", precision: 5, scale: 2
      t.decimal "product_design_to_meet_clients_need", precision: 5, scale: 2
      t.decimal "treat_clients_responsibly", precision: 5, scale: 2
      t.decimal "treat_employees_responsibly", precision: 5, scale: 2
      t.decimal "balance_financial_and_performance", precision: 5, scale: 2
      t.decimal "promote_environmental_protection", precision: 5, scale: 2
      t.datetime "data_viewed_at", null: false
    end

    create_table :archive_v_institutions_covenants, if_not_exists: true do |t|
      t.string "institution_name"
      t.string "iM_group"
      t.decimal "par30", precision: 8, scale: 4
      t.decimal "par30_limit", precision: 8, scale: 4
      t.decimal "par30_refy", precision: 8, scale: 4
      t.decimal "par30_refy_limit", precision: 8, scale: 4
      t.decimal "roa", precision: 8, scale: 4
      t.decimal "roa_limit", precision: 8, scale: 4
      t.decimal "adj_roa", precision: 8, scale: 4
      t.decimal "adj_roa_limit", precision: 8, scale: 4
      t.decimal "open_fx_exposure", precision: 8, scale: 4
      t.decimal "open_fx_exposure_limit", precision: 8, scale: 4
      t.decimal "open_loan_position", precision: 8, scale: 4
      t.decimal "open_loan_position_limit", precision: 8, scale: 4
      t.decimal "car", precision: 8, scale: 4
      t.decimal "car_limit", precision: 8, scale: 4
      t.decimal "deposits_liabilities", precision: 8, scale: 4
      t.decimal "deposits_liabilities_limit", precision: 8, scale: 4
      t.decimal "maturity_matching_if_applicable", precision: 8, scale: 4
      t.decimal "maturity_matching_if_applicable_limit", precision: 8, scale: 4
      t.decimal "liquid_assets_deposits_if_applicable", precision: 8, scale: 4
      t.decimal "liquid_assets_deposits_if_applicable_limit", precision: 8, scale: 4
      t.datetime "data_viewed_at", null: false
    end

    create_table :archive_v_loans, if_not_exists: true do |t|
      t.bigint "loan_id"
      t.integer "version_number"
      t.string "status"
      t.string "version_status"
      t.bigint "currency_id"
      t.bigint "loan_type_id"
      t.bigint "repayment_type_id"
      t.bigint "creation_user_id"
      t.date "assignment_date"
      t.date "deadline_assignment_date"
      t.date "ratification_date"
      t.date "deadline_ratification_date"
      t.date "approval_date"
      t.date "deadline_approval_date"
      t.date "expected_disbursement_date"
      t.string "specific_approval_condition"
      t.float "probabilities"
      t.date "disbursement_date"
      t.boolean "in_waiting_list"
      t.date "maturity_date"
      t.float "nav_usd"
      t.decimal "net_position_value", precision: 17, scale: 2
      t.decimal "gross_position_value", precision: 17, scale: 2
      t.string "critical_cases"
      t.date "provision_date"
      t.decimal "provision_value", precision: 17, scale: 2
      t.string "vrr"
      t.date "vrr_maturity_date"
      t.decimal "proposed_nominal_amount", precision: 17, scale: 2
      t.integer "proposed_tenor"
      t.float "proposed_spread"
      t.float "proposed_upfront_fees"
      t.float "proposed_fixed_rate"
      t.decimal "ratified_nominal_amount", precision: 17, scale: 2
      t.integer "ratified_tenor"
      t.float "ratified_spread"
      t.float "ratified_upfront_fees"
      t.float "ratified_fixed_rate"
      t.decimal "approved_nominal_amount", precision: 17, scale: 2
      t.integer "approved_tenor"
      t.float "approved_spread"
      t.float "approved_upfront_fees"
      t.float "approved_fixed_rate"
      t.decimal "executed_nominal_amount", precision: 17, scale: 2
      t.integer "executed_tenor"
      t.float "executed_spread"
      t.float "executed_upfront_fees"
      t.float "executed_fixed_rate"
      t.decimal "pending_ratification_nominal_amount", precision: 17, scale: 2
      t.integer "pending_ratification_tenor"
      t.float "pending_ratification_spread"
      t.float "pending_ratification_upfront_fees"
      t.float "pending_ratification_fixed_rate"
      t.date "pending_ratification_date"
      t.date "deadline_pending_ratification_date"
      t.decimal "pending_approval_nominal_amount", precision: 17, scale: 2
      t.integer "pending_approval_tenor"
      t.float "pending_approval_spread"
      t.float "pending_approval_upfront_fees"
      t.float "pending_approval_fixed_rate"
      t.date "pending_approval_date"
      t.date "deadline_pending_approval_date"
      t.decimal "approved_change_request_nominal_amount", precision: 17, scale: 2
      t.integer "approved_change_request_tenor"
      t.float "approved_change_request_spread"
      t.float "approved_change_request_upfront_fees"
      t.float "approved_change_request_fixed_rate"
      t.date "approval_change_request_date"
      t.date "deadline_approval_change_request_date"
      t.bigint "validation_user_id"
      t.bigint "rejection_user_id"
      t.datetime "created_at", precision: 6
      t.datetime "updated_at", precision: 6
      t.date "deleted_at"
      t.bigint "bond_id"
      t.bigint "pool_id"
      t.bigint "interest_rate_type_id"
      t.string "invested_hedge", limit: 100
      t.text "pending_ratification_comment"
      t.text "ratified_comment"
      t.text "not_ratified_comment"
      t.text "assignement_expired_comment"
      t.text "released_before_approval_comment"
      t.text "pending_approval_comment"
      t.text "approved_comment"
      t.text "not_approved_comment"
      t.text "approval_expired_comment"
      t.text "approved_change_request_comment"
      t.text "invested_comment"
      t.text "released_after_approval_comment"
      t.text "not_validated_comment"
      t.date "nav_date"
      t.integer "innpact_loan_id", null: false
      t.string "institution_mode_at_creation", null: false
      t.integer "last_loan_version", null: false
      t.integer "noval"
      t.boolean "restructuring", null: false
      t.bigint "tranche_original_loan_id"
      t.decimal "proposed_nominal_amount_USD", precision: 38, scale: 17
      t.decimal "ratified_nominal_amount_USD", precision: 38, scale: 17
      t.decimal "approved_nominal_amount_USD", precision: 38, scale: 17
      t.decimal "executed_nominal_amount_USD", precision: 38, scale: 17
      t.decimal "pending_ratification_nominal_amount_USD", precision: 38, scale: 17
      t.decimal "pending_approval_nominal_amount_USD", precision: 38, scale: 17
      t.decimal "approved_change_request_nominal_amount_USD", precision: 38, scale: 17
      t.string "Institutions"
      t.string "Institution_group"
      t.boolean "in_watchlist"
      t.string "institution_type"
      t.string "fund_name"
      t.integer "fund_status"
      t.string "loan_type_description"
      t.string "loan_type"
      t.string "Country"
      t.string "rating_MOODYS"
      t.integer "rating_MIMOSA"
      t.string "Region"
      t.string "Local_Currency"
      t.decimal "Local_Currency_Rate", precision: 17, scale: 6
      t.string "repayment_type"
      t.string "bond"
      t.string "bond_description"
      t.string "interest_rate_type"
      t.string "interest_rate_type_description"
      t.string "pool"
      t.string "IM_Group"
      t.date "data_viewed_at"
      t.datetime "SysStartTime"
      t.datetime "SysEndTime"
    end
  end
end
