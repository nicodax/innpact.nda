# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2023_02_21_141302) do

  create_table "MSSQL_TemporalHistoryFor_1026102696", id: false, force: :cascade do |t|
    t.bigint "id", null: false
    t.bigint "loan_request_id", null: false
    t.string "document", null: false
    t.string "original_filename"
    t.string "slug"
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "SysStartTime", precision: 7, null: false
    t.datetime "SysEndTime", precision: 7, null: false
    t.index ["SysEndTime", "SysStartTime"], name: "ix_MSSQL_TemporalHistoryFor_1026102696"
  end

  create_table "MSSQL_TemporalHistoryFor_1029578706", id: false, force: :cascade do |t|
    t.bigint "id", null: false
    t.string "email", null: false
    t.string "encrypted_password", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer "invitation_limit"
    t.string "invited_by_type"
    t.bigint "invited_by_id"
    t.integer "invitations_count"
    t.string "firstname"
    t.string "lastname"
    t.datetime "deleted_at"
    t.string "phone_number"
    t.datetime "SysStartTime", precision: 7, null: false
    t.datetime "SysEndTime", precision: 7, null: false
    t.index ["SysEndTime", "SysStartTime"], name: "ix_MSSQL_TemporalHistoryFor_1029578706"
  end

  create_table "MSSQL_TemporalHistoryFor_1125579048", id: false, force: :cascade do |t|
    t.bigint "id", null: false
    t.string "name"
    t.string "resource_type"
    t.bigint "resource_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "SysStartTime", precision: 7, null: false
    t.datetime "SysEndTime", precision: 7, null: false
    t.index ["SysEndTime", "SysStartTime"], name: "ix_MSSQL_TemporalHistoryFor_1125579048"
  end

  create_table "MSSQL_TemporalHistoryFor_1138103095", id: false, force: :cascade do |t|
    t.bigint "id", null: false
    t.bigint "fund_id", null: false
    t.integer "innpact_loan_id", null: false
    t.bigint "institution_id"
    t.bigint "creation_user_id", null: false
    t.date "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "noval"
    t.string "institution_mode_at_creation", null: false
    t.integer "last_loan_version", null: false
    t.boolean "restructuring", null: false
    t.bigint "im_group_id"
    t.bigint "original_loan_id"
    t.datetime "copied_at"
    t.datetime "SysStartTime", precision: 7, null: false
    t.datetime "SysEndTime", precision: 7, null: false
    t.index ["SysEndTime", "SysStartTime"], name: "ix_MSSQL_TemporalHistoryFor_1138103095"
  end

  create_table "MSSQL_TemporalHistoryFor_1173579219", id: false, force: :cascade do |t|
    t.bigint "id", null: false
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "status"
    t.text "details"
    t.datetime "deleted_at"
    t.string "created_by", null: false
    t.datetime "SysStartTime", precision: 7, null: false
    t.datetime "SysEndTime", precision: 7, null: false
    t.index ["SysEndTime", "SysStartTime"], name: "ix_MSSQL_TemporalHistoryFor_1173579219"
  end

  create_table "MSSQL_TemporalHistoryFor_1301579675", id: false, force: :cascade do |t|
    t.bigint "id", null: false
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "deleted_at"
    t.string "iso_code"
    t.integer "population"
    t.string "rating"
    t.decimal "gdp", precision: 17, scale: 2
    t.decimal "gdp_per_capita", precision: 17, scale: 2
    t.decimal "gni", precision: 17, scale: 2
    t.decimal "gni_per_capita", precision: 17, scale: 2
    t.integer "mimosa_score"
    t.boolean "is_a_high_income_country"
    t.string "created_by", null: false
    t.bigint "fund_id", null: false
    t.bigint "country_group_id"
    t.datetime "SysStartTime", precision: 7, null: false
    t.datetime "SysEndTime", precision: 7, null: false
    t.index ["SysEndTime", "SysStartTime"], name: "ix_MSSQL_TemporalHistoryFor_1301579675"
  end

  create_table "MSSQL_TemporalHistoryFor_1330103779", id: false, force: :cascade do |t|
    t.bigint "id", null: false
    t.bigint "loan_id", null: false
    t.integer "version_number", null: false
    t.string "status", null: false
    t.string "version_status", null: false
    t.bigint "currency_id"
    t.bigint "loan_type_id"
    t.bigint "repayment_type_id"
    t.bigint "creation_user_id", null: false
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
    t.boolean "in_waiting_list", null: false
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
    t.float "loan_spread"
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
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.date "deleted_at"
    t.bigint "executed_bond_id"
    t.bigint "pool_id"
    t.bigint "loan_interest_rate_type_id"
    t.string "hedge_comment", limit: 100
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
    t.datetime "SysStartTime", precision: 7, null: false
    t.datetime "SysEndTime", precision: 7, null: false
    t.bigint "approved_bond_id"
    t.bigint "approved_interest_rate_type_id"
    t.integer "number_of_disbursement_date_updates"
    t.decimal "invested_hedge_fx_rate", precision: 18, scale: 9
    t.datetime "presentable_at"
    t.float "hedge_spread"
    t.bigint "hedge_interest_rate_type_id"
    t.index ["SysEndTime", "SysStartTime"], name: "ix_MSSQL_TemporalHistoryFor_1330103779"
  end

  create_table "MSSQL_TemporalHistoryFor_1349579846", id: false, force: :cascade do |t|
    t.bigint "id", null: false
    t.string "name"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "description"
    t.datetime "deleted_at"
    t.bigint "fund_id", null: false
    t.datetime "SysStartTime", precision: 7, null: false
    t.datetime "SysEndTime", precision: 7, null: false
    t.index ["SysEndTime", "SysStartTime"], name: "ix_MSSQL_TemporalHistoryFor_1349579846"
  end

  create_table "MSSQL_TemporalHistoryFor_1397580017", id: false, force: :cascade do |t|
    t.bigint "id", null: false
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "deleted_at"
    t.string "created_by", null: false
    t.bigint "fund_id", null: false
    t.datetime "SysStartTime", precision: 7, null: false
    t.datetime "SysEndTime", precision: 7, null: false
    t.index ["SysEndTime", "SysStartTime"], name: "ix_MSSQL_TemporalHistoryFor_1397580017"
  end

  create_table "MSSQL_TemporalHistoryFor_1445580188", id: false, force: :cascade do |t|
    t.bigint "id", null: false
    t.string "name"
    t.bigint "country_id", null: false
    t.bigint "institution_group_id", null: false
    t.decimal "microfinance_portfolio_size", precision: 18, scale: 2
    t.decimal "sme_portfolio_size_under_35k", precision: 18, scale: 2
    t.bigint "borrowers_count"
    t.bigint "female_borrowers_count"
    t.bigint "rural_borrowers_count_to_be_deleted"
    t.string "internal_rating_to_be_deleted"
    t.string "external_rating_to_be_deleted"
    t.integer "tier"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "deleted_at"
    t.bigint "institution_type_id", null: false
    t.integer "ia_esg_rating_to_be_deleted"
    t.boolean "environmental_rating_to_be_deleted"
    t.string "cpps_adoption"
    t.string "kyc_check_to_be_deleted"
    t.boolean "use_of_standard_reporting_tools_boolean"
    t.boolean "involvement_in_responsible_finance_initiatives_to_be_deleted"
    t.boolean "training_on_responsible_finance_targeting_women_to_be_deleted"
    t.boolean "provision_of_financial_products_targeting_enterprise_set_up_to_be_deleted"
    t.decimal "liabilities", precision: 18, scale: 2
    t.decimal "domestic_liabilities_to_be_deleted", precision: 18, scale: 2
    t.decimal "international_liabilities_to_be_deleted", precision: 18, scale: 2
    t.string "calendar_liabilities_and_assets_to_be_deleted"
    t.decimal "revenues_to_be_deleted", precision: 18, scale: 2
    t.decimal "net_income_distributed_as_dividends_to_be_deleted", precision: 17, scale: 2
    t.decimal "provision_for_loss_to_be_deleted", precision: 18, scale: 2
    t.decimal "write_off_to_be_deleted", precision: 5, scale: 2
    t.decimal "deposit_amount_to_be_deleted", precision: 18, scale: 2
    t.boolean "saving_to_be_deleted"
    t.decimal "saving_amount_to_be_deleted", precision: 18, scale: 2
    t.boolean "mobile_banking_services_to_be_deleted"
    t.string "list_dfi_lenders_to_be_deleted"
    t.string "financial_strength_of_shareholders_to_be_deleted", limit: 50
    t.bigint "number_of_micro_borrowers_to_be_deleted"
    t.bigint "number_of_sme_borrowers_to_be_deleted"
    t.decimal "services_to_be_deleted", precision: 17, scale: 2
    t.decimal "production_to_be_deleted", precision: 17, scale: 2
    t.decimal "microenterprise_usd_to_be_deleted", precision: 18, scale: 2
    t.decimal "sme_usd_to_be_deleted", precision: 18, scale: 2
    t.decimal "corporate_usd_to_be_deleted", precision: 18, scale: 2
    t.decimal "housing_usd_to_be_deleted", precision: 18, scale: 2
    t.decimal "personal_usd_to_be_deleted", precision: 18, scale: 2
    t.decimal "other_usd_to_be_deleted", precision: 18, scale: 2
    t.boolean "has_sptf_alinus_reporting_using_alinus_to_be_deleted"
    t.string "sptf_alinus_reporting_using_alinus_to_be_deleted", limit: 15
    t.decimal "overall_sptf_alinus_score_to_be_deleted", precision: 5, scale: 2
    t.decimal "define_and_monitor_social_goals_to_be_deleted", precision: 5, scale: 2
    t.decimal "ensure_commitment_to_social_goals_to_be_deleted", precision: 5, scale: 2
    t.decimal "product_design_to_meet_clients_need_to_be_deleted", precision: 5, scale: 2
    t.decimal "treat_clients_responsibly_to_be_deleted", precision: 5, scale: 2
    t.decimal "treat_employees_responsibly_to_be_deleted", precision: 5, scale: 2
    t.decimal "balance_financial_and_performance_to_be_deleted", precision: 5, scale: 2
    t.decimal "promote_environmental_protection_to_be_deleted", precision: 5, scale: 2
    t.decimal "trade_to_be_deleted", precision: 17, scale: 2
    t.decimal "agriculture_to_be_deleted", precision: 17, scale: 2
    t.decimal "education_to_be_deleted", precision: 17, scale: 2
    t.decimal "housing_to_be_deleted", precision: 17, scale: 2
    t.decimal "consumption_to_be_deleted", precision: 17, scale: 2
    t.decimal "other_to_be_deleted", precision: 17, scale: 2
    t.decimal "total_assets", precision: 18, scale: 2
    t.decimal "gross_loan_portfolio", precision: 18, scale: 2
    t.decimal "portfolio_3y_ago_to_be_deleted", precision: 18, scale: 2
    t.decimal "equity", precision: 18, scale: 2
    t.decimal "other_liabilities_to_be_deleted", precision: 18, scale: 2
    t.decimal "net_income", precision: 18, scale: 2
    t.decimal "avg_loan_size", precision: 18, scale: 2
    t.boolean "deposits_to_be_deleted"
    t.boolean "in_watchlist"
    t.string "watchlist_reason"
    t.date "watchlist_entry_date"
    t.bigint "fund_id", null: false
    t.bigint "im_group_id"
    t.date "general_as_of_date"
    t.date "financials_as_of_date"
    t.date "clients_as_of_date"
    t.date "portfolio_breakdown_i_as_of_date"
    t.date "portfolio_breakdown_ii_as_of_date_to_be_deleted"
    t.date "portfolio_breakdown_iii_as_of_date_to_be_deleted"
    t.date "aptf_alinus_results_as_of_date_to_be_deleted"
    t.datetime "SysStartTime", precision: 7, null: false
    t.datetime "SysEndTime", precision: 7, null: false
    t.string "external_rating_agency_to_be_deleted"
    t.decimal "npls_to_be_deleted", precision: 5, scale: 2
    t.string "internal_impact_score_to_be_deleted"
    t.integer "number_of_clients_to_be_deleted"
    t.decimal "mobile_banking_percentage_to_be_deleted", precision: 5, scale: 2
    t.decimal "trade_and_services_to_be_deleted", precision: 5, scale: 2
    t.string "regulatory_status"
    t.decimal "probability_of_default_to_be_deleted", precision: 18
    t.decimal "sme_portfolio_size_under_50k_to_be_deleted", precision: 18
    t.decimal "percentage_rural_ptf_to_be_deleted", precision: 5, scale: 2
    t.decimal "percentage_of_women_ptf_to_be_deleted", precision: 5, scale: 2
    t.boolean "voluntary_savings_to_be_deleted"
    t.integer "number_clients_using_mobile_banking_to_be_deleted"
    t.integer "number_clients_with_deposits_to_be_deleted"
    t.date "services_offered_as_of_date_to_be_deleted"
    t.datetime "general_rating_as_of_date_to_be_deleted"
    t.string "internal_credit_risk_rating_to_be_deleted"
    t.string "use_of_standard_reporting_tools"
    t.index ["SysEndTime", "SysStartTime"], name: "ix_MSSQL_TemporalHistoryFor_1445580188"
  end

  create_table "MSSQL_TemporalHistoryFor_1509580416", id: false, force: :cascade do |t|
    t.bigint "id", null: false
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "description"
    t.datetime "deleted_at"
    t.bigint "fund_id", null: false
    t.datetime "SysStartTime", precision: 7, null: false
    t.datetime "SysEndTime", precision: 7, null: false
    t.index ["SysEndTime", "SysStartTime"], name: "ix_MSSQL_TemporalHistoryFor_1509580416"
  end

  create_table "MSSQL_TemporalHistoryFor_1522104463", id: false, force: :cascade do |t|
    t.bigint "id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "creation_user_id", null: false
    t.string "version_status", null: false
    t.bigint "validation_user_id"
    t.bigint "rejection_user_id"
    t.bigint "loan_version_id"
    t.datetime "deleted_at"
    t.datetime "SysStartTime", precision: 7, null: false
    t.datetime "SysEndTime", precision: 7, null: false
    t.index ["SysEndTime", "SysStartTime"], name: "ix_MSSQL_TemporalHistoryFor_1522104463"
  end

  create_table "MSSQL_TemporalHistoryFor_1570104634", id: false, force: :cascade do |t|
    t.bigint "id", null: false
    t.bigint "repayment_calendar_id", null: false
    t.date "repayment_date", null: false
    t.string "repayment_type", null: false
    t.decimal "original_amount", precision: 17, scale: 2, null: false
    t.decimal "received_amount", precision: 17, scale: 2, null: false
    t.string "status", null: false
    t.decimal "provision", precision: 17, scale: 2, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "previous_version_line_id"
    t.datetime "deleted_at"
    t.datetime "SysStartTime", precision: 7, null: false
    t.datetime "SysEndTime", precision: 7, null: false
    t.index ["SysEndTime", "SysStartTime"], name: "ix_MSSQL_TemporalHistoryFor_1570104634"
  end

  create_table "MSSQL_TemporalHistoryFor_162099618", id: false, force: :cascade do |t|
    t.bigint "id", null: false
    t.bigint "pool_id", null: false
    t.bigint "institution_group_id", null: false
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "SysStartTime", precision: 7, null: false
    t.datetime "SysEndTime", precision: 7, null: false
    t.index ["SysEndTime", "SysStartTime"], name: "ix_MSSQL_TemporalHistoryFor_162099618"
  end

  create_table "MSSQL_TemporalHistoryFor_1621580815", id: false, force: :cascade do |t|
    t.bigint "id", null: false
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "description"
    t.datetime "deleted_at"
    t.bigint "fund_id", null: false
    t.datetime "SysStartTime", precision: 7, null: false
    t.datetime "SysEndTime", precision: 7, null: false
    t.index ["SysEndTime", "SysStartTime"], name: "ix_MSSQL_TemporalHistoryFor_1621580815"
  end

  create_table "MSSQL_TemporalHistoryFor_1653580929", id: false, force: :cascade do |t|
    t.bigint "id", null: false
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "description"
    t.datetime "deleted_at"
    t.bigint "fund_id", null: false
    t.datetime "SysStartTime", precision: 7, null: false
    t.datetime "SysEndTime", precision: 7, null: false
    t.index ["SysEndTime", "SysStartTime"], name: "ix_MSSQL_TemporalHistoryFor_1653580929"
  end

  create_table "MSSQL_TemporalHistoryFor_1685581043", id: false, force: :cascade do |t|
    t.bigint "id", null: false
    t.decimal "rate", precision: 17, scale: 6
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.date "expired_date"
    t.bigint "currency_id"
    t.datetime "deleted_at"
    t.string "created_by", null: false
    t.datetime "SysStartTime", precision: 7, null: false
    t.datetime "SysEndTime", precision: 7, null: false
    t.index ["SysEndTime", "SysStartTime"], name: "ix_MSSQL_TemporalHistoryFor_1685581043"
  end

  create_table "MSSQL_TemporalHistoryFor_1717581157", id: false, force: :cascade do |t|
    t.bigint "id", null: false
    t.string "short_name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "name"
    t.datetime "deleted_at"
    t.integer "priority"
    t.bigint "country_id"
    t.bigint "fund_id", null: false
    t.datetime "SysStartTime", precision: 7, null: false
    t.datetime "SysEndTime", precision: 7, null: false
    t.index ["SysEndTime", "SysStartTime"], name: "ix_MSSQL_TemporalHistoryFor_1717581157"
  end

  create_table "MSSQL_TemporalHistoryFor_1730105204", id: false, force: :cascade do |t|
    t.bigint "id", null: false
    t.bigint "repayment_calendar_id", null: false
    t.bigint "creation_user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "deleted_at"
    t.datetime "SysStartTime", precision: 7, null: false
    t.datetime "SysEndTime", precision: 7, null: false
    t.index ["SysEndTime", "SysStartTime"], name: "ix_MSSQL_TemporalHistoryFor_1730105204"
  end

  create_table "MSSQL_TemporalHistoryFor_1749581271", id: false, force: :cascade do |t|
    t.bigint "id", null: false
    t.float "amount", null: false
    t.bigint "fund_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "deleted_at"
    t.datetime "SysStartTime", precision: 7, null: false
    t.datetime "SysEndTime", precision: 7, null: false
    t.index ["SysEndTime", "SysStartTime"], name: "ix_MSSQL_TemporalHistoryFor_1749581271"
  end

  create_table "MSSQL_TemporalHistoryFor_1778105375", id: false, force: :cascade do |t|
    t.bigint "id", null: false
    t.bigint "calendar_log_id", null: false
    t.string "action", null: false
    t.bigint "original_repayment_line_id"
    t.string "changed_attribute"
    t.string "original_value"
    t.string "new_value"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "new_repayment_line_id"
    t.datetime "deleted_at"
    t.datetime "SysStartTime", precision: 7, null: false
    t.datetime "SysEndTime", precision: 7, null: false
    t.index ["SysEndTime", "SysStartTime"], name: "ix_MSSQL_TemporalHistoryFor_1778105375"
  end

  create_table "MSSQL_TemporalHistoryFor_1829581556", id: false, force: :cascade do |t|
    t.bigint "id", null: false
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "deleted_at"
    t.date "subscription_date", null: false
    t.boolean "has_maturity_date", null: false
    t.date "maturity_date"
    t.decimal "amount", precision: 17, scale: 2, null: false
    t.bigint "currency_id", null: false
    t.decimal "amount_in_usd", precision: 17, scale: 2, null: false
    t.boolean "required_specific_reporting", null: false
    t.boolean "is_targeted", null: false
    t.bigint "fund_id", null: false
    t.datetime "SysStartTime", precision: 7, null: false
    t.datetime "SysEndTime", precision: 7, null: false
    t.index ["SysEndTime", "SysStartTime"], name: "ix_MSSQL_TemporalHistoryFor_1829581556"
  end

  create_table "MSSQL_TemporalHistoryFor_1861581670", id: false, force: :cascade do |t|
    t.bigint "id", null: false
    t.decimal "amount_in_usd", precision: 17, scale: 2
    t.bigint "pool_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "deleted_at"
    t.decimal "amount_in_percent", precision: 5, scale: 2
    t.string "is_target_in_usd_or_percent", null: false
    t.datetime "SysStartTime", precision: 7, null: false
    t.datetime "SysEndTime", precision: 7, null: false
    t.index ["SysEndTime", "SysStartTime"], name: "ix_MSSQL_TemporalHistoryFor_1861581670"
  end

  create_table "MSSQL_TemporalHistoryFor_1890105774", id: false, force: :cascade do |t|
    t.bigint "id", null: false
    t.string "name", null: false
    t.string "description", null: false
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "fund_id"
    t.datetime "SysStartTime", precision: 7, null: false
    t.datetime "SysEndTime", precision: 7, null: false
    t.index ["SysEndTime", "SysStartTime"], name: "ix_MSSQL_TemporalHistoryFor_1890105774"
  end

  create_table "MSSQL_TemporalHistoryFor_1909581841", id: false, force: :cascade do |t|
    t.bigint "id", null: false
    t.bigint "pool_id", null: false
    t.bigint "country_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "deleted_at"
    t.datetime "SysStartTime", precision: 7, null: false
    t.datetime "SysEndTime", precision: 7, null: false
    t.index ["SysEndTime", "SysStartTime"], name: "ix_MSSQL_TemporalHistoryFor_1909581841"
  end

  create_table "MSSQL_TemporalHistoryFor_1922105888", id: false, force: :cascade do |t|
    t.bigint "id", null: false
    t.string "name", null: false
    t.string "description", null: false
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "fund_id", null: false
    t.datetime "SysStartTime", precision: 7, null: false
    t.datetime "SysEndTime", precision: 7, null: false
    t.index ["SysEndTime", "SysStartTime"], name: "ix_MSSQL_TemporalHistoryFor_1922105888"
  end

  create_table "MSSQL_TemporalHistoryFor_1970106059", id: false, force: :cascade do |t|
    t.bigint "id", null: false
    t.float "percentage", null: false
    t.float "previous_percentage_of_provision", null: false
    t.float "new_percentage_of_provision", null: false
    t.string "comment", null: false
    t.bigint "institution_id", null: false
    t.bigint "creation_user_id", null: false
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "version_status", null: false
    t.datetime "SysStartTime", precision: 7, null: false
    t.datetime "SysEndTime", precision: 7, null: false
    t.index ["SysEndTime", "SysStartTime"], name: "ix_MSSQL_TemporalHistoryFor_1970106059"
  end

  create_table "MSSQL_TemporalHistoryFor_1973582069", id: false, force: :cascade do |t|
    t.bigint "id", null: false
    t.bigint "pool_id", null: false
    t.bigint "institution_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "deleted_at"
    t.datetime "SysStartTime", precision: 7, null: false
    t.datetime "SysEndTime", precision: 7, null: false
    t.index ["SysEndTime", "SysStartTime"], name: "ix_MSSQL_TemporalHistoryFor_1973582069"
  end

  create_table "MSSQL_TemporalHistoryFor_2018106230", id: false, force: :cascade do |t|
    t.bigint "id", null: false
    t.float "percentage"
    t.float "previous_amount_of_provision", null: false
    t.float "new_amount_of_provision", null: false
    t.bigint "loan_id", null: false
    t.bigint "institution_provision_id"
    t.bigint "repayment_calendar_id", null: false
    t.bigint "creation_user_id", null: false
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.float "amount"
    t.datetime "SysStartTime", precision: 7, null: false
    t.datetime "SysEndTime", precision: 7, null: false
    t.index ["SysEndTime", "SysStartTime"], name: "ix_MSSQL_TemporalHistoryFor_2018106230"
  end

  create_table "MSSQL_TemporalHistoryFor_2037582297", id: false, force: :cascade do |t|
    t.bigint "id", null: false
    t.bigint "pool_id", null: false
    t.string "document", null: false
    t.string "original_filename", null: false
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "slug", null: false
    t.datetime "SysStartTime", precision: 7, null: false
    t.datetime "SysEndTime", precision: 7, null: false
    t.index ["SysEndTime", "SysStartTime"], name: "ix_MSSQL_TemporalHistoryFor_2037582297"
  end

  create_table "MSSQL_TemporalHistoryFor_206623779", id: false, force: :cascade do |t|
    t.bigint "id", null: false
    t.string "name", null: false
    t.string "description"
    t.bigint "fund_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "SysStartTime", precision: 7, null: false
    t.datetime "SysEndTime", precision: 7, null: false
    t.index ["SysEndTime", "SysStartTime"], name: "ix_MSSQL_TemporalHistoryFor_206623779"
  end

  create_table "MSSQL_TemporalHistoryFor_226099846", id: false, force: :cascade do |t|
    t.bigint "id", null: false
    t.bigint "pool_id", null: false
    t.bigint "currency_id", null: false
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "SysStartTime", precision: 7, null: false
    t.datetime "SysEndTime", precision: 7, null: false
    t.index ["SysEndTime", "SysStartTime"], name: "ix_MSSQL_TemporalHistoryFor_226099846"
  end

  create_table "MSSQL_TemporalHistoryFor_290100074", id: false, force: :cascade do |t|
    t.bigint "id", null: false
    t.bigint "pool_id", null: false
    t.bigint "loan_type_id", null: false
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "SysStartTime", precision: 7, null: false
    t.datetime "SysEndTime", precision: 7, null: false
    t.index ["SysEndTime", "SysStartTime"], name: "ix_MSSQL_TemporalHistoryFor_290100074"
  end

  create_table "MSSQL_TemporalHistoryFor_418100530", id: false, force: :cascade do |t|
    t.bigint "id", null: false
    t.string "name"
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "fund_id", null: false
    t.string "description"
    t.datetime "SysStartTime", precision: 7, null: false
    t.datetime "SysEndTime", precision: 7, null: false
    t.index ["SysEndTime", "SysStartTime"], name: "ix_MSSQL_TemporalHistoryFor_418100530"
  end

  create_table "MSSQL_TemporalHistoryFor_482100758", id: false, force: :cascade do |t|
    t.bigint "id", null: false
    t.bigint "pool_id", null: false
    t.bigint "institution_type_id", null: false
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "SysStartTime", precision: 7, null: false
    t.datetime "SysEndTime", precision: 7, null: false
    t.index ["SysEndTime", "SysStartTime"], name: "ix_MSSQL_TemporalHistoryFor_482100758"
  end

  create_table "MSSQL_TemporalHistoryFor_50099219", id: false, force: :cascade do |t|
    t.bigint "id", null: false
    t.bigint "pool_id", null: false
    t.string "document", null: false
    t.string "original_filename", null: false
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "slug", null: false
    t.datetime "SysStartTime", precision: 7, null: false
    t.datetime "SysEndTime", precision: 7, null: false
    t.index ["SysEndTime", "SysStartTime"], name: "ix_MSSQL_TemporalHistoryFor_50099219"
  end

  create_table "MSSQL_TemporalHistoryFor_546100986", id: false, force: :cascade do |t|
    t.bigint "id", null: false
    t.decimal "amount", precision: 18, null: false
    t.datetime "date", null: false
    t.bigint "institution_id", null: false
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "SysStartTime", precision: 7, null: false
    t.datetime "SysEndTime", precision: 7, null: false
    t.index ["SysEndTime", "SysStartTime"], name: "ix_MSSQL_TemporalHistoryFor_546100986"
  end

  create_table "MSSQL_TemporalHistoryFor_594101157", id: false, force: :cascade do |t|
    t.bigint "id", null: false
    t.decimal "amount", precision: 18, null: false
    t.datetime "date", null: false
    t.bigint "institution_id", null: false
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "SysStartTime", precision: 7, null: false
    t.datetime "SysEndTime", precision: 7, null: false
    t.index ["SysEndTime", "SysStartTime"], name: "ix_MSSQL_TemporalHistoryFor_594101157"
  end

  create_table "MSSQL_TemporalHistoryFor_658101385", id: false, force: :cascade do |t|
    t.bigint "id", null: false
    t.bigint "currency_id", null: false
    t.bigint "country_id", null: false
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "SysStartTime", precision: 7, null: false
    t.datetime "SysEndTime", precision: 7, null: false
    t.index ["SysEndTime", "SysStartTime"], name: "ix_MSSQL_TemporalHistoryFor_658101385"
  end

  create_table "MSSQL_TemporalHistoryFor_754101727", id: false, force: :cascade do |t|
    t.bigint "id", null: false
    t.bigint "institution_id", null: false
    t.string "name"
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
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "fund_id", null: false
    t.datetime "SysStartTime", precision: 7, null: false
    t.datetime "SysEndTime", precision: 7, null: false
    t.index ["SysEndTime", "SysStartTime"], name: "ix_MSSQL_TemporalHistoryFor_754101727"
  end

  create_table "MSSQL_TemporalHistoryFor_802101898", id: false, force: :cascade do |t|
    t.bigint "id", null: false
    t.bigint "fund_id", null: false
    t.bigint "user_id", null: false
    t.bigint "institution_id"
    t.float "spread"
    t.float "upfront_fees"
    t.float "fixed_rate"
    t.integer "nominal_amount_usd"
    t.integer "nominal_amount_local_currency"
    t.bigint "currency_id"
    t.integer "tenor"
    t.float "execution_probability"
    t.bigint "repayment_type_id"
    t.string "mfi_pays"
    t.integer "interest_payment_frequency"
    t.bigint "loan_type_id"
    t.integer "tranche"
    t.string "intermediary"
    t.float "syndication_amount"
    t.string "hedge_structure"
    t.date "assignement_date"
    t.date "expected_dibursement_date"
    t.boolean "sme_window", null: false
    t.boolean "approved", null: false
    t.boolean "waiting_list", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "innpact_loan_id", null: false
    t.string "swap_link"
    t.bigint "assigned_investment_manager_id"
    t.datetime "submitted_at"
    t.datetime "deleted_at"
    t.datetime "SysStartTime", precision: 7, null: false
    t.datetime "SysEndTime", precision: 7, null: false
    t.index ["SysEndTime", "SysStartTime"], name: "ix_MSSQL_TemporalHistoryFor_802101898"
  end

  create_table "MSSQL_TemporalHistoryFor_98099390", id: false, force: :cascade do |t|
    t.bigint "id", null: false
    t.bigint "pool_id", null: false
    t.bigint "country_group_id", null: false
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "SysStartTime", precision: 7, null: false
    t.datetime "SysEndTime", precision: 7, null: false
    t.index ["SysEndTime", "SysStartTime"], name: "ix_MSSQL_TemporalHistoryFor_98099390"
  end

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.string "service_name", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "additional_pais_environments", force: :cascade do |t|
    t.bigint "institution_id", null: false
    t.bigint "user_id"
    t.string "environment_pai_reported"
    t.decimal "environment_pai_value", precision: 23, scale: 7
    t.datetime "deleted_at"
    t.datetime "as_of", default: -> { "getdate()" }
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["institution_id"], name: "index_additional_pais_environments_on_institution_id"
    t.index ["user_id"], name: "index_additional_pais_environments_on_user_id"
  end

  create_table "additional_pais_socials", force: :cascade do |t|
    t.bigint "institution_id", null: false
    t.bigint "user_id"
    t.string "social_pai_reported"
    t.decimal "social_pai_value", precision: 23, scale: 7
    t.datetime "deleted_at"
    t.datetime "as_of", default: -> { "getdate()" }
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["institution_id"], name: "index_additional_pais_socials_on_institution_id"
    t.index ["user_id"], name: "index_additional_pais_socials_on_user_id"
  end

  create_table "administrators", force: :cascade do |t|
    t.string "email"
    t.string "password_digest"
    t.string "first_name"
    t.string "last_name"
    t.string "remember_token"
    t.datetime "remember_token_expires_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "archive_cash_flows", force: :cascade do |t|
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

  create_table "archive_v_additional_pai_environments", force: :cascade do |t|
    t.string "institution_id"
    t.string "institution_name"
    t.datetime "pais_environment_as_of"
    t.string "environment_pai_reported"
    t.decimal "environment_pai_value", precision: 18, scale: 2
    t.datetime "data_viewed_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "archive_v_additional_pai_socials", force: :cascade do |t|
    t.string "institution_id"
    t.string "institution_name"
    t.datetime "pais_social_as_of"
    t.string "social_pai_reported"
    t.decimal "social_pai_value", precision: 18, scale: 2
    t.datetime "data_viewed_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "archive_v_institutions", force: :cascade do |t|
    t.date "general_time_stamp"
    t.string "name"
    t.string "assigned_IM_group"
    t.string "country"
    t.string "institution_group"
    t.string "institution_type"
    t.integer "ia_esg_rating"
    t.string "internal_rating"
    t.string "external_rating"
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
    t.decimal "write_off", precision: 5, scale: 2
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
    t.decimal "sme_portfolio_size_under_35k", precision: 18, scale: 2
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
    t.string "external_rating_agency"
    t.decimal "npls", precision: 5, scale: 2
    t.decimal "trade_and_services", precision: 5, scale: 2
    t.string "regulatory_status"
    t.decimal "probability_of_default", precision: 18
    t.decimal "sme_portfolio_size_under_50k", precision: 18
    t.decimal "percentage_rural_ptf", precision: 5, scale: 2
    t.decimal "percentage_of_women_ptf", precision: 5, scale: 2
    t.boolean "voluntary_savings"
    t.integer "number_clients_using_mobile_banking"
    t.integer "number_clients_with_deposits"
    t.datetime "general_rating_as_of_date"
    t.string "internal_credit_risk_rating"
    t.string "use_of_standard_reporting_tools_sptf_alinus"
    t.datetime "rating_as_of"
    t.decimal "npls_USD", precision: 18, scale: 2
    t.decimal "write_off_USD", precision: 18, scale: 2
    t.datetime "institution_specific_breakdowns_as_of"
    t.decimal "sector_trade_and_services_percent", precision: 5, scale: 2
    t.decimal "agriculture_percent", precision: 5, scale: 2
    t.decimal "production_percent", precision: 5, scale: 2
    t.decimal "consumption_percent", precision: 5, scale: 2
    t.decimal "by_sector_other_percent", precision: 5, scale: 2
    t.decimal "loan_purpose_microenterprise_percent", precision: 5, scale: 2
    t.decimal "loan_purpose_sme_percent", precision: 5, scale: 2
    t.decimal "loan_purpose_corporate_percent", precision: 5, scale: 2
    t.decimal "loan_purpose_housing_percent", precision: 5, scale: 2
    t.decimal "loan_purpose_personal_percent", precision: 5, scale: 2
    t.decimal "loan_purpose_other_percent", precision: 5, scale: 2
    t.datetime "impact_indicator_as_of_date"
    t.string "internal_impact_score"
    t.integer "number_of_clients"
    t.datetime "services_offered_as_of_date"
    t.datetime "esg_gender_equalities_as_of_date"
    t.decimal "women_percentage_in_board", precision: 5, scale: 2
    t.decimal "women_percentage_in_management", precision: 5, scale: 2
    t.decimal "women_percentage_in_staff", precision: 5, scale: 2
    t.decimal "percentage_women_among_loan_officers", precision: 5, scale: 2
    t.decimal "financial_services_targeting_women", precision: 5, scale: 2
    t.decimal "non_financial_services_targeting_women", precision: 5, scale: 2
    t.datetime "esg_risk_as_of"
    t.text "tool_use_for_esg_score"
    t.string "internal_esg_score", limit: 10
    t.string "ifc_esg_risk_financial_intermediaries_classification"
    t.boolean "esms_in_place_commensurate_with_risk_profile"
    t.datetime "esg_safeguards_as_of"
    t.boolean "compliance_with_fund_exclusion_list"
    t.boolean "compliance_with_international_labour_organization_standards"
    t.boolean "compliance_with_international_bill_of_human_rights"
    t.boolean "compliance_with_guiding_principles_on_business_and_human_rights"
    t.boolean "compliance_with_oecd_guidelines_for_multinational_enterprises"
    t.boolean "compliance_with_national_standards_and_law"
    t.boolean "compliance_with_client_protection_principles"
    t.datetime "pai_indicator_as_of"
    t.decimal "scope_1_emissions", precision: 18, scale: 2
    t.decimal "scope_2_emissions", precision: 18, scale: 2
    t.decimal "scope_3_emissions", precision: 18, scale: 2
    t.decimal "carbon_footprint", precision: 18, scale: 2
    t.decimal "ghg_intensity_investee_companies", precision: 18, scale: 2
    t.decimal "exposure_companies_active_in_fossil_fuel_sector", precision: 5, scale: 2
    t.decimal "share_of_non_renewable_energy_consumption_and_production", precision: 5, scale: 2
    t.decimal "energy_consumption_intensity_per_high_impact_climate_sector", precision: 18, scale: 2
    t.decimal "activities_negatively_affecting_biodiversity_sensitive_areas", precision: 5, scale: 2
    t.decimal "emissions_to_water", precision: 18, scale: 2
    t.decimal "hazardous_waste_ratio", precision: 18, scale: 2
    t.decimal "violations_of_un_global_compact_principles_and_oecd_guidelines_for_multinational_enterprises", precision: 5, scale: 2
    t.decimal "lack_of_processes_and_compliance_mechanisms_to_monitor_compliance_with_un_global_compact_principles", precision: 5, scale: 2
    t.decimal "unadjusted_gender_pay_gap", precision: 5, scale: 2
    t.decimal "board_gender_diversity", precision: 5, scale: 2
    t.decimal "exposure_to_controversial_weapons", precision: 5, scale: 2
  end

  create_table "archive_v_institutions_covenants", force: :cascade do |t|
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

  create_table "archive_v_loans", force: :cascade do |t|
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
    t.string "hedge_comment", limit: 100
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
    t.bigint "executed_bond_id"
    t.bigint "executed_interest_rate_type_id"
    t.bigint "approved_bond_id"
    t.bigint "approved_interest_rate_type_id"
    t.integer "number_of_disbursement_date_updates"
    t.decimal "invested_hedge_fx_rate", precision: 18, scale: 9
    t.bigint "loan_version_id"
    t.string "presentable"
    t.datetime "presentable_at"
    t.boolean "sdg_goal_01"
    t.boolean "sdg_goal_02"
    t.boolean "sdg_goal_03"
    t.boolean "sdg_goal_04"
    t.boolean "sdg_goal_05"
    t.boolean "sdg_goal_06"
    t.boolean "sdg_goal_07"
    t.boolean "sdg_goal_08"
    t.boolean "sdg_goal_09"
    t.boolean "sdg_goal_10"
    t.boolean "sdg_goal_11"
    t.boolean "sdg_goal_12"
    t.boolean "sdg_goal_13"
    t.boolean "sdg_goal_14"
    t.boolean "sdg_goal_15"
    t.boolean "sdg_goal_16"
    t.boolean "sdg_goal_17"
    t.string "proposed_investment_complies_with_mef_guidelines"
    t.string "investee_microfinance_portfolio_greater_than_two_times_mef_loan"
    t.string "kyc_check"
    t.string "aml_risk_rate"
    t.string "aml_country_risk_assessment"
    t.string "tax_report_assessment"
    t.float "hedge_spread"
    t.bigint "hedge_interest_rate_type_id"
    t.bigint "loan_interest_rate_type_id"
    t.float "loan_spread"
  end

  create_table "bonds", force: :cascade do |t|
    t.string "name", null: false
    t.string "description", null: false
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "fund_id"
    t.datetime "SysStartTime", precision: 7, default: -> { "sysutcdatetime()" }, null: false
    t.datetime "SysEndTime", precision: 7, default: '12-31-9999 23:59:59.9999999', null: false
    t.index ["fund_id"], name: "index_bonds_on_fund_id"
  end

  create_table "calendar_log_lines", force: :cascade do |t|
    t.bigint "calendar_log_id", null: false
    t.string "action", null: false
    t.bigint "original_repayment_line_id"
    t.string "changed_attribute"
    t.string "original_value"
    t.string "new_value"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "new_repayment_line_id"
    t.datetime "deleted_at"
    t.datetime "SysStartTime", precision: 7, default: -> { "sysutcdatetime()" }, null: false
    t.datetime "SysEndTime", precision: 7, default: '12-31-9999 23:59:59.9999999', null: false
    t.index ["calendar_log_id"], name: "index_calendar_log_lines_on_calendar_log_id"
    t.index ["new_repayment_line_id"], name: "index_calendar_log_lines_on_new_repayment_line_id"
    t.index ["original_repayment_line_id"], name: "index_calendar_log_lines_on_original_repayment_line_id"
  end

  create_table "calendar_logs", force: :cascade do |t|
    t.bigint "repayment_calendar_id", null: false
    t.bigint "creation_user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "deleted_at"
    t.datetime "SysStartTime", precision: 7, default: -> { "sysutcdatetime()" }, null: false
    t.datetime "SysEndTime", precision: 7, default: '12-31-9999 23:59:59.9999999', null: false
    t.index ["creation_user_id"], name: "index_calendar_logs_on_creation_user_id"
    t.index ["repayment_calendar_id"], name: "index_calendar_logs_on_repayment_calendar_id"
  end

  create_table "countries", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "deleted_at"
    t.string "iso_code"
    t.integer "population"
    t.string "rating"
    t.decimal "gdp", precision: 17, scale: 2
    t.decimal "gdp_per_capita", precision: 17, scale: 2
    t.decimal "gni", precision: 17, scale: 2
    t.decimal "gni_per_capita", precision: 17, scale: 2
    t.integer "mimosa_score"
    t.boolean "is_a_high_income_country"
    t.string "created_by", null: false
    t.bigint "fund_id", null: false
    t.bigint "country_group_id"
    t.datetime "SysStartTime", precision: 7, default: -> { "sysutcdatetime()" }, null: false
    t.datetime "SysEndTime", precision: 7, default: '12-31-9999 23:59:59.9999999', null: false
    t.index ["country_group_id"], name: "index_countries_on_country_group_id", where: "([country_group_id] IS NOT NULL)"
    t.index ["deleted_at"], name: "index_countries_on_deleted_at"
    t.index ["fund_id"], name: "index_countries_on_fund_id"
  end

  create_table "country_groups", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "description"
    t.datetime "deleted_at"
    t.bigint "fund_id", null: false
    t.datetime "SysStartTime", precision: 7, default: -> { "sysutcdatetime()" }, null: false
    t.datetime "SysEndTime", precision: 7, default: '12-31-9999 23:59:59.9999999', null: false
    t.index ["deleted_at"], name: "index_country_groups_on_deleted_at"
    t.index ["fund_id"], name: "index_country_groups_on_fund_id"
  end

  create_table "currencies", force: :cascade do |t|
    t.string "short_name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "name"
    t.datetime "deleted_at"
    t.integer "priority"
    t.bigint "country_id"
    t.bigint "fund_id", null: false
    t.datetime "SysStartTime", precision: 7, default: -> { "sysutcdatetime()" }, null: false
    t.datetime "SysEndTime", precision: 7, default: '12-31-9999 23:59:59.9999999', null: false
    t.index ["country_id"], name: "index_currencies_on_country_id"
    t.index ["deleted_at"], name: "index_currencies_on_deleted_at"
    t.index ["fund_id"], name: "index_currencies_on_fund_id"
  end

  create_table "currency_countries", force: :cascade do |t|
    t.bigint "currency_id", null: false
    t.bigint "country_id", null: false
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "SysStartTime", precision: 7, default: -> { "sysutcdatetime()" }, null: false
    t.datetime "SysEndTime", precision: 7, default: '12-31-9999 23:59:59.9999999', null: false
    t.index ["country_id"], name: "index_currency_countries_on_country_id"
    t.index ["currency_id"], name: "index_currency_countries_on_currency_id"
  end

  create_table "currency_rates", force: :cascade do |t|
    t.decimal "rate", precision: 17, scale: 6
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.date "expired_date"
    t.bigint "currency_id"
    t.datetime "deleted_at"
    t.string "created_by", null: false
    t.datetime "SysStartTime", precision: 7, default: -> { "sysutcdatetime()" }, null: false
    t.datetime "SysEndTime", precision: 7, default: '12-31-9999 23:59:59.9999999', null: false
    t.index ["deleted_at"], name: "index_currency_rates_on_deleted_at"
  end

  create_table "dashboard_notifications", force: :cascade do |t|
    t.bigint "user_id"
    t.string "notification_type", null: false
    t.string "notification_object_type"
    t.integer "notification_object_id"
    t.datetime "checked_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_dashboard_notifications_on_user_id"
  end

  create_table "default_limits", force: :cascade do |t|
    t.string "model"
    t.integer "value"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "deleted_at"
    t.string "description"
    t.bigint "fund_id", null: false
    t.index ["deleted_at"], name: "index_default_limits_on_deleted_at"
    t.index ["fund_id"], name: "index_default_limits_on_fund_id"
  end

  create_table "fund_usd_amounts", force: :cascade do |t|
    t.float "amount", null: false
    t.bigint "fund_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "deleted_at"
    t.datetime "SysStartTime", precision: 7, default: -> { "sysutcdatetime()" }, null: false
    t.datetime "SysEndTime", precision: 7, default: '12-31-9999 23:59:59.9999999', null: false
    t.index ["fund_id"], name: "index_fund_usd_amounts_on_fund_id"
  end

  create_table "funds", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "status"
    t.text "details"
    t.datetime "deleted_at"
    t.string "created_by", null: false
    t.datetime "SysStartTime", precision: 7, default: -> { "sysutcdatetime()" }, null: false
    t.datetime "SysEndTime", precision: 7, default: '12-31-9999 23:59:59.9999999', null: false
    t.index ["deleted_at"], name: "index_funds_on_deleted_at"
  end

  create_table "funds_users", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "fund_id", null: false
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["fund_id"], name: "index_funds_users_on_fund_id"
    t.index ["user_id"], name: "index_funds_users_on_user_id"
  end

  create_table "im_groups", force: :cascade do |t|
    t.string "name", null: false
    t.string "description"
    t.bigint "fund_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "SysStartTime", precision: 7, default: -> { "sysutcdatetime()" }, null: false
    t.datetime "SysEndTime", precision: 7, default: '12-31-9999 23:59:59.9999999', null: false
    t.index ["fund_id"], name: "index_im_groups_on_fund_id"
    t.index ["name", "fund_id"], name: "index_im_groups_on_name_and_fund_id", unique: true
  end

  create_table "im_groups_users", id: false, force: :cascade do |t|
    t.bigint "im_group_id"
    t.bigint "user_id"
    t.index ["im_group_id"], name: "index_im_groups_users_on_im_group_id"
    t.index ["user_id"], name: "index_im_groups_users_on_user_id"
  end

  create_table "institution_alinus_results", force: :cascade do |t|
    t.bigint "institution_id", null: false
    t.bigint "user_id"
    t.decimal "overall_sptf_alinus_score", precision: 5, scale: 2
    t.decimal "define_and_monitor_social_goals", precision: 5, scale: 2
    t.decimal "ensure_commitment_to_social_goals", precision: 5, scale: 2
    t.decimal "product_design_to_meet_clients_need", precision: 5, scale: 2
    t.decimal "treat_clients_responsibly", precision: 5, scale: 2
    t.decimal "treat_employees_responsibly", precision: 5, scale: 2
    t.decimal "balance_financial_and_performance", precision: 5, scale: 2
    t.decimal "promote_environmental_protection", precision: 5, scale: 2
    t.datetime "deleted_at"
    t.datetime "as_of", default: -> { "getdate()" }
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["institution_id"], name: "index_institution_alinus_results_on_institution_id"
    t.index ["user_id"], name: "index_institution_alinus_results_on_user_id"
  end

  create_table "institution_assets", force: :cascade do |t|
    t.decimal "amount", precision: 18, null: false
    t.datetime "date", null: false
    t.bigint "institution_id", null: false
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "SysStartTime", precision: 7, default: -> { "sysutcdatetime()" }, null: false
    t.datetime "SysEndTime", precision: 7, default: '12-31-9999 23:59:59.9999999', null: false
    t.index ["institution_id"], name: "index_institution_assets_on_institution_id"
  end

  create_table "institution_covenants", force: :cascade do |t|
    t.bigint "institution_id", null: false
    t.string "name"
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
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "fund_id", null: false
    t.datetime "SysStartTime", precision: 7, default: -> { "sysutcdatetime()" }, null: false
    t.datetime "SysEndTime", precision: 7, default: '12-31-9999 23:59:59.9999999', null: false
    t.index ["fund_id"], name: "index_institution_covenants_on_fund_id"
    t.index ["institution_id"], name: "index_institution_covenants_on_institution_id"
  end

  create_table "institution_esg_gender_equalities", force: :cascade do |t|
    t.bigint "institution_id", null: false
    t.decimal "women_percentage_in_board", precision: 5, scale: 2
    t.decimal "women_percentage_in_staff", precision: 5, scale: 2
    t.boolean "financial_services_targeting_women"
    t.boolean "non_financial_services_targeting_women"
    t.datetime "deleted_at"
    t.datetime "as_of", default: -> { "getdate()" }
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "user_id"
    t.boolean "training_on_responsible_finance_targeting_women"
    t.decimal "women_percentage_in_management", precision: 5, scale: 2
    t.decimal "percentage_loans_to_women_borrowers_per_glp", precision: 5, scale: 2
    t.decimal "percentage_women_among_loan_officers", precision: 5, scale: 2
    t.index ["institution_id"], name: "index_institution_esg_gender_equalities_on_institution_id"
    t.index ["user_id"], name: "index_institution_esg_gender_equalities_on_user_id"
  end

  create_table "institution_esg_pai_indicators", force: :cascade do |t|
    t.bigint "institution_id", null: false
    t.decimal "scope_1_emissions", precision: 23, scale: 7
    t.decimal "scope_2_emissions", precision: 23, scale: 7
    t.decimal "scope_3_emissions", precision: 23, scale: 7
    t.decimal "carbon_footprint", precision: 23, scale: 7
    t.decimal "ghg_intensity_investee_companies", precision: 23, scale: 7
    t.decimal "exposure_companies_active_in_fossil_fuel_sector", precision: 10, scale: 7
    t.decimal "share_of_non_renewable_energy_consumption_and_production", precision: 10, scale: 7
    t.decimal "energy_consumption_intensity_per_high_impact_climate_sector", precision: 23, scale: 7
    t.decimal "activities_negatively_affecting_biodiversity_sensitive_areas", precision: 10, scale: 7
    t.decimal "emissions_to_water", precision: 23, scale: 7
    t.decimal "hazardous_waste_ratio", precision: 23, scale: 7
    t.decimal "violations_of_un_global_compact_principles_and_oecd_guidelines_for_multinational_enterprises", precision: 10, scale: 7
    t.decimal "lack_of_processes_and_compliance_mechanisms_to_monitor_compliance_with_un_global_compact_principles", precision: 10, scale: 7
    t.decimal "unadjusted_gender_pay_gap", precision: 10, scale: 7
    t.decimal "board_gender_diversity", precision: 10, scale: 7
    t.decimal "exposure_to_controversial_weapons", precision: 10, scale: 7
    t.datetime "deleted_at"
    t.datetime "as_of", default: -> { "getdate()" }
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "user_id"
    t.index ["institution_id"], name: "index_institution_esg_pai_indicators_on_institution_id"
    t.index ["user_id"], name: "index_institution_esg_pai_indicators_on_user_id"
  end

  create_table "institution_esg_risks", force: :cascade do |t|
    t.bigint "institution_id", null: false
    t.string "internal_esg_score", limit: 10
    t.string "ifc_esg_risk_financial_intermediaries_classification"
    t.boolean "esms_in_place_commensurate_with_risk_profile"
    t.datetime "deleted_at"
    t.datetime "as_of", default: -> { "getdate()" }
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "user_id"
    t.text "tool_use_for_esg_score"
    t.index ["institution_id"], name: "index_institution_esg_risks_on_institution_id"
    t.index ["user_id"], name: "index_institution_esg_risks_on_user_id"
  end

  create_table "institution_esg_safeguards", force: :cascade do |t|
    t.bigint "institution_id", null: false
    t.boolean "compliance_with_fund_exclusion_list"
    t.boolean "compliance_with_international_labour_organization_standards"
    t.boolean "compliance_with_international_bill_of_human_rights"
    t.boolean "compliance_with_guiding_principles_on_business_and_human_rights"
    t.string "compliance_with_oecd_guidelines_for_multinational_enterprises"
    t.boolean "compliance_with_national_standards_and_law"
    t.boolean "compliance_with_client_protection_principles"
    t.datetime "deleted_at"
    t.datetime "as_of", default: -> { "getdate()" }
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "user_id"
    t.index ["institution_id"], name: "index_institution_esg_safeguards_on_institution_id"
    t.index ["user_id"], name: "index_institution_esg_safeguards_on_user_id"
  end

  create_table "institution_esg_sdg_contributions", force: :cascade do |t|
    t.bigint "institution_id", null: false
    t.boolean "no_poverty", default: false, null: false
    t.boolean "zero_hunger", default: false, null: false
    t.boolean "good_health_and_wellbeing", default: false, null: false
    t.boolean "quality_education", default: false, null: false
    t.boolean "gender_equality", default: false, null: false
    t.boolean "clean_water_and_sanitation", default: false, null: false
    t.boolean "affordable_and_clean_energy", default: false, null: false
    t.boolean "descent_work_and_economic_growth", default: false, null: false
    t.boolean "industry_innovation_and_infrastructure", default: false, null: false
    t.boolean "reduced_inequalities", default: false, null: false
    t.boolean "sustainable_cities_and_communities", default: false, null: false
    t.boolean "responsible_consumption_and_production", default: false, null: false
    t.boolean "climate_action", default: false, null: false
    t.boolean "life_below_water", default: false, null: false
    t.boolean "life_on_land", default: false, null: false
    t.boolean "peace_justice_and_strong_institutions", default: false, null: false
    t.boolean "partnerships_for_the_goals", default: false, null: false
    t.datetime "as_of", default: -> { "getdate()" }
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "user_id"
    t.index ["institution_id"], name: "index_institution_esg_sdg_contributions_on_institution_id"
    t.index ["user_id"], name: "index_institution_esg_sdg_contributions_on_user_id"
  end

  create_table "institution_financials", force: :cascade do |t|
    t.bigint "institution_id", null: false
    t.bigint "user_id"
    t.decimal "liabilities", precision: 18, scale: 2
    t.decimal "domestic_liabilities", precision: 18, scale: 2
    t.decimal "international_liabilities", precision: 18, scale: 2
    t.decimal "revenues", precision: 18, scale: 2
    t.decimal "net_income_distributed_as_dividends", precision: 18, scale: 2
    t.decimal "provision_for_loss", precision: 18, scale: 2
    t.decimal "write_off", precision: 18, scale: 2
    t.decimal "deposit_amount", precision: 18, scale: 2
    t.decimal "total_assets", precision: 18, scale: 2
    t.decimal "gross_loan_portfolio", precision: 18, scale: 2
    t.decimal "equity", precision: 18, scale: 2
    t.decimal "net_income", precision: 18, scale: 2
    t.decimal "npls", precision: 18, scale: 2
    t.datetime "deleted_at"
    t.datetime "as_of", default: -> { "getdate()" }
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["institution_id"], name: "index_institution_financials_on_institution_id"
    t.index ["user_id"], name: "index_institution_financials_on_user_id"
  end

  create_table "institution_groups", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "deleted_at"
    t.string "created_by", null: false
    t.bigint "fund_id", null: false
    t.datetime "SysStartTime", precision: 7, default: -> { "sysutcdatetime()" }, null: false
    t.datetime "SysEndTime", precision: 7, default: '12-31-9999 23:59:59.9999999', null: false
    t.index ["deleted_at"], name: "index_institution_groups_on_deleted_at"
    t.index ["fund_id"], name: "index_institution_groups_on_fund_id"
  end

  create_table "institution_impact_indicators", force: :cascade do |t|
    t.bigint "institution_id", null: false
    t.bigint "user_id"
    t.bigint "borrowers_count"
    t.bigint "female_borrowers_count"
    t.bigint "rural_borrowers_count"
    t.bigint "number_of_micro_borrowers"
    t.bigint "number_of_sme_borrowers"
    t.decimal "avg_loan_size", precision: 18, scale: 2
    t.string "internal_impact_score"
    t.integer "number_of_clients"
    t.datetime "deleted_at"
    t.datetime "as_of", default: -> { "getdate()" }
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["institution_id"], name: "index_institution_impact_indicators_on_institution_id"
    t.index ["user_id"], name: "index_institution_impact_indicators_on_user_id"
  end

  create_table "institution_liabilities", force: :cascade do |t|
    t.decimal "amount", precision: 18, null: false
    t.datetime "date", null: false
    t.bigint "institution_id", null: false
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "SysStartTime", precision: 7, default: -> { "sysutcdatetime()" }, null: false
    t.datetime "SysEndTime", precision: 7, default: '12-31-9999 23:59:59.9999999', null: false
    t.index ["institution_id"], name: "index_institution_liabilities_on_institution_id"
  end

  create_table "institution_profiles", force: :cascade do |t|
    t.bigint "institution_id", null: false
    t.bigint "user_id"
    t.integer "tier"
    t.string "cpps_adoption"
    t.string "use_of_standard_reporting_tools"
    t.string "regulatory_status"
    t.datetime "deleted_at"
    t.datetime "as_of", default: -> { "getdate()" }
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["institution_id"], name: "index_institution_profiles_on_institution_id"
    t.index ["user_id"], name: "index_institution_profiles_on_user_id"
  end

  create_table "institution_provisions", force: :cascade do |t|
    t.float "percentage", null: false
    t.float "previous_percentage_of_provision", null: false
    t.float "new_percentage_of_provision", null: false
    t.string "comment", null: false
    t.bigint "institution_id", null: false
    t.bigint "creation_user_id", null: false
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "version_status", default: "temporary", null: false
    t.datetime "SysStartTime", precision: 7, default: -> { "sysutcdatetime()" }, null: false
    t.datetime "SysEndTime", precision: 7, default: '12-31-9999 23:59:59.9999999', null: false
    t.index ["creation_user_id"], name: "index_institution_provisions_on_creation_user_id"
    t.index ["institution_id"], name: "index_institution_provisions_on_institution_id"
  end

  create_table "institution_ratings", force: :cascade do |t|
    t.bigint "institution_id", null: false
    t.bigint "user_id"
    t.string "external_rating"
    t.string "external_rating_agency"
    t.string "internal_credit_risk_rating"
    t.decimal "probability_of_default", precision: 18
    t.datetime "deleted_at"
    t.datetime "as_of", default: -> { "getdate()" }
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["institution_id"], name: "index_institution_ratings_on_institution_id"
    t.index ["user_id"], name: "index_institution_ratings_on_user_id"
  end

  create_table "institution_specific_breakdowns", force: :cascade do |t|
    t.bigint "institution_id", null: false
    t.bigint "user_id"
    t.decimal "microfinance_portfolio_size", precision: 18, scale: 2
    t.decimal "sme_portfolio_size_under_35k", precision: 18, scale: 2
    t.decimal "sme_portfolio_size_under_50k", precision: 18, scale: 2
    t.decimal "percentage_loans_to_rural_borrowers_per_glp", precision: 5, scale: 2
    t.datetime "deleted_at"
    t.datetime "as_of", default: -> { "getdate()" }
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.decimal "production", precision: 17, scale: 2
    t.decimal "agriculture", precision: 17, scale: 2
    t.decimal "consumption", precision: 17, scale: 2
    t.decimal "by_sector_other", precision: 17, scale: 2
    t.decimal "trade_and_services", precision: 17, scale: 2
    t.decimal "microenterprise", precision: 18, scale: 2
    t.decimal "sme", precision: 18, scale: 2
    t.decimal "corporate", precision: 18, scale: 2
    t.decimal "housing", precision: 18, scale: 2
    t.decimal "personal", precision: 18, scale: 2
    t.decimal "by_loan_purpose_other", precision: 18, scale: 2
    t.index ["institution_id"], name: "index_institution_specific_breakdowns_on_institution_id"
    t.index ["user_id"], name: "index_institution_specific_breakdowns_on_user_id"
  end

  create_table "institution_types", force: :cascade do |t|
    t.string "name"
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "fund_id", null: false
    t.string "description"
    t.datetime "SysStartTime", precision: 7, default: -> { "sysutcdatetime()" }, null: false
    t.datetime "SysEndTime", precision: 7, default: '12-31-9999 23:59:59.9999999', null: false
    t.index ["fund_id"], name: "index_institution_types_on_fund_id"
  end

  create_table "institutions", force: :cascade do |t|
    t.string "name"
    t.bigint "country_id", null: false
    t.bigint "institution_group_id", null: false
    t.decimal "microfinance_portfolio_size", precision: 18, scale: 2
    t.decimal "sme_portfolio_size_under_35k", precision: 18, scale: 2
    t.bigint "borrowers_count"
    t.bigint "female_borrowers_count"
    t.bigint "rural_borrowers_count_to_be_deleted"
    t.string "internal_rating_to_be_deleted"
    t.string "external_rating_to_be_deleted"
    t.integer "tier"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "deleted_at"
    t.bigint "institution_type_id", null: false
    t.integer "ia_esg_rating_to_be_deleted"
    t.boolean "environmental_rating_to_be_deleted"
    t.string "cpps_adoption"
    t.string "kyc_check_to_be_deleted"
    t.boolean "use_of_standard_reporting_tools_boolean"
    t.boolean "involvement_in_responsible_finance_initiatives_to_be_deleted"
    t.boolean "training_on_responsible_finance_targeting_women_to_be_deleted"
    t.boolean "provision_of_financial_products_targeting_enterprise_set_up_to_be_deleted"
    t.decimal "liabilities", precision: 18, scale: 2
    t.decimal "domestic_liabilities_to_be_deleted", precision: 18, scale: 2
    t.decimal "international_liabilities_to_be_deleted", precision: 18, scale: 2
    t.string "calendar_liabilities_and_assets_to_be_deleted"
    t.decimal "revenues_to_be_deleted", precision: 18, scale: 2
    t.decimal "net_income_distributed_as_dividends_to_be_deleted", precision: 17, scale: 2
    t.decimal "provision_for_loss_to_be_deleted", precision: 18, scale: 2
    t.decimal "write_off_to_be_deleted", precision: 5, scale: 2
    t.decimal "deposit_amount_to_be_deleted", precision: 18, scale: 2
    t.boolean "saving_to_be_deleted"
    t.decimal "saving_amount_to_be_deleted", precision: 18, scale: 2
    t.boolean "mobile_banking_services_to_be_deleted"
    t.string "list_dfi_lenders_to_be_deleted"
    t.string "financial_strength_of_shareholders_to_be_deleted", limit: 50
    t.bigint "number_of_micro_borrowers_to_be_deleted"
    t.bigint "number_of_sme_borrowers_to_be_deleted"
    t.decimal "services_to_be_deleted", precision: 17, scale: 2
    t.decimal "production_to_be_deleted", precision: 17, scale: 2
    t.decimal "microenterprise_usd_to_be_deleted", precision: 18, scale: 2
    t.decimal "sme_usd_to_be_deleted", precision: 18, scale: 2
    t.decimal "corporate_usd_to_be_deleted", precision: 18, scale: 2
    t.decimal "housing_usd_to_be_deleted", precision: 18, scale: 2
    t.decimal "personal_usd_to_be_deleted", precision: 18, scale: 2
    t.decimal "other_usd_to_be_deleted", precision: 18, scale: 2
    t.boolean "has_sptf_alinus_reporting_using_alinus_to_be_deleted"
    t.string "sptf_alinus_reporting_using_alinus_to_be_deleted", limit: 15
    t.decimal "overall_sptf_alinus_score_to_be_deleted", precision: 5, scale: 2
    t.decimal "define_and_monitor_social_goals_to_be_deleted", precision: 5, scale: 2
    t.decimal "ensure_commitment_to_social_goals_to_be_deleted", precision: 5, scale: 2
    t.decimal "product_design_to_meet_clients_need_to_be_deleted", precision: 5, scale: 2
    t.decimal "treat_clients_responsibly_to_be_deleted", precision: 5, scale: 2
    t.decimal "treat_employees_responsibly_to_be_deleted", precision: 5, scale: 2
    t.decimal "balance_financial_and_performance_to_be_deleted", precision: 5, scale: 2
    t.decimal "promote_environmental_protection_to_be_deleted", precision: 5, scale: 2
    t.decimal "trade_to_be_deleted", precision: 17, scale: 2
    t.decimal "agriculture_to_be_deleted", precision: 17, scale: 2
    t.decimal "education_to_be_deleted", precision: 17, scale: 2
    t.decimal "housing_to_be_deleted", precision: 17, scale: 2
    t.decimal "consumption_to_be_deleted", precision: 17, scale: 2
    t.decimal "other_to_be_deleted", precision: 17, scale: 2
    t.decimal "total_assets", precision: 18, scale: 2
    t.decimal "gross_loan_portfolio", precision: 18, scale: 2
    t.decimal "portfolio_3y_ago_to_be_deleted", precision: 18, scale: 2
    t.decimal "equity", precision: 18, scale: 2
    t.decimal "other_liabilities_to_be_deleted", precision: 18, scale: 2
    t.decimal "net_income", precision: 18, scale: 2
    t.decimal "avg_loan_size", precision: 18, scale: 2
    t.boolean "deposits_to_be_deleted"
    t.boolean "in_watchlist"
    t.string "watchlist_reason"
    t.date "watchlist_entry_date"
    t.bigint "fund_id", null: false
    t.bigint "im_group_id"
    t.date "general_as_of_date"
    t.date "financials_as_of_date"
    t.date "clients_as_of_date"
    t.date "portfolio_breakdown_i_as_of_date"
    t.date "portfolio_breakdown_ii_as_of_date_to_be_deleted"
    t.date "portfolio_breakdown_iii_as_of_date_to_be_deleted"
    t.date "aptf_alinus_results_as_of_date_to_be_deleted"
    t.datetime "SysStartTime", precision: 7, default: -> { "sysutcdatetime()" }, null: false
    t.datetime "SysEndTime", precision: 7, default: '12-31-9999 23:59:59.9999999', null: false
    t.string "external_rating_agency_to_be_deleted"
    t.decimal "npls_to_be_deleted", precision: 5, scale: 2
    t.string "internal_impact_score_to_be_deleted"
    t.integer "number_of_clients_to_be_deleted"
    t.decimal "mobile_banking_percentage_to_be_deleted", precision: 5, scale: 2
    t.decimal "trade_and_services_to_be_deleted", precision: 5, scale: 2
    t.string "regulatory_status"
    t.decimal "probability_of_default_to_be_deleted", precision: 18
    t.decimal "sme_portfolio_size_under_50k_to_be_deleted", precision: 18
    t.decimal "percentage_rural_ptf_to_be_deleted", precision: 5, scale: 2
    t.decimal "percentage_of_women_ptf_to_be_deleted", precision: 5, scale: 2
    t.boolean "voluntary_savings_to_be_deleted"
    t.integer "number_clients_using_mobile_banking_to_be_deleted"
    t.integer "number_clients_with_deposits_to_be_deleted"
    t.date "services_offered_as_of_date_to_be_deleted"
    t.datetime "general_rating_as_of_date_to_be_deleted"
    t.string "internal_credit_risk_rating_to_be_deleted"
    t.string "use_of_standard_reporting_tools"
    t.index ["country_id"], name: "index_institutions_on_country_id"
    t.index ["deleted_at"], name: "index_institutions_on_deleted_at"
    t.index ["fund_id"], name: "index_institutions_on_fund_id"
    t.index ["im_group_id"], name: "index_institutions_on_im_group_id"
    t.index ["institution_group_id"], name: "index_institutions_on_institution_group_id"
    t.index ["institution_type_id"], name: "index_institutions_on_institution_type_id"
  end

  create_table "interest_rate_types", force: :cascade do |t|
    t.string "name", null: false
    t.string "description", null: false
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "fund_id", null: false
    t.datetime "SysStartTime", precision: 7, default: -> { "sysutcdatetime()" }, null: false
    t.datetime "SysEndTime", precision: 7, default: '12-31-9999 23:59:59.9999999', null: false
    t.index ["fund_id"], name: "index_interest_rate_types_on_fund_id"
  end

  create_table "limit_exceptions", force: :cascade do |t|
    t.string "model"
    t.integer "model_id"
    t.integer "value"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "deleted_at"
    t.string "description"
    t.bigint "fund_id", null: false
    t.index ["deleted_at"], name: "index_limit_exceptions_on_deleted_at"
    t.index ["fund_id"], name: "index_limit_exceptions_on_fund_id"
  end

  create_table "loan_provisions", force: :cascade do |t|
    t.float "percentage"
    t.float "previous_amount_of_provision", null: false
    t.float "new_amount_of_provision", null: false
    t.bigint "loan_id", null: false
    t.bigint "institution_provision_id"
    t.bigint "repayment_calendar_id", null: false
    t.bigint "creation_user_id", null: false
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.float "amount"
    t.datetime "SysStartTime", precision: 7, default: -> { "sysutcdatetime()" }, null: false
    t.datetime "SysEndTime", precision: 7, default: '12-31-9999 23:59:59.9999999', null: false
    t.index ["creation_user_id"], name: "index_loan_provisions_on_creation_user_id"
    t.index ["institution_provision_id"], name: "index_loan_provisions_on_institution_provision_id"
    t.index ["loan_id"], name: "index_loan_provisions_on_loan_id"
    t.index ["repayment_calendar_id"], name: "index_loan_provisions_on_repayment_calendar_id"
  end

  create_table "loan_request_documents", force: :cascade do |t|
    t.bigint "loan_request_id", null: false
    t.string "document", null: false
    t.string "original_filename"
    t.string "slug"
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "SysStartTime", precision: 7, default: -> { "sysutcdatetime()" }, null: false
    t.datetime "SysEndTime", precision: 7, default: '12-31-9999 23:59:59.9999999', null: false
    t.index ["loan_request_id"], name: "index_loan_request_documents_on_loan_request_id"
  end

  create_table "loan_requests", force: :cascade do |t|
    t.bigint "fund_id", null: false
    t.bigint "user_id", null: false
    t.bigint "institution_id"
    t.float "spread"
    t.float "upfront_fees"
    t.float "fixed_rate"
    t.integer "nominal_amount_usd"
    t.integer "nominal_amount_local_currency"
    t.bigint "currency_id"
    t.integer "tenor"
    t.float "execution_probability"
    t.bigint "repayment_type_id"
    t.string "mfi_pays"
    t.integer "interest_payment_frequency"
    t.bigint "loan_type_id"
    t.integer "tranche"
    t.string "intermediary"
    t.float "syndication_amount"
    t.string "hedge_structure"
    t.date "assignement_date"
    t.date "expected_dibursement_date"
    t.boolean "sme_window", default: false, null: false
    t.boolean "approved", default: false, null: false
    t.boolean "waiting_list", default: true, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "innpact_loan_id", default: 1, null: false
    t.string "swap_link"
    t.bigint "assigned_investment_manager_id"
    t.datetime "submitted_at"
    t.datetime "deleted_at"
    t.datetime "SysStartTime", precision: 7, default: -> { "sysutcdatetime()" }, null: false
    t.datetime "SysEndTime", precision: 7, default: '12-31-9999 23:59:59.9999999', null: false
    t.index ["currency_id"], name: "index_loan_requests_on_currency_id"
    t.index ["fund_id"], name: "index_loan_requests_on_fund_id"
    t.index ["innpact_loan_id"], name: "index_loan_requests_on_innpact_loan_id", unique: true
    t.index ["institution_id"], name: "index_loan_requests_on_institution_id"
    t.index ["loan_type_id"], name: "index_loan_requests_on_loan_type_id"
    t.index ["repayment_type_id"], name: "index_loan_requests_on_repayment_type_id"
    t.index ["user_id"], name: "index_loan_requests_on_user_id"
  end

  create_table "loan_sdg_data", force: :cascade do |t|
    t.bigint "loan_id", null: false
    t.boolean "no_poverty", default: false, null: false
    t.boolean "zero_hunger", default: false, null: false
    t.boolean "good_health_and_wellbeing", default: false, null: false
    t.boolean "quality_education", default: false, null: false
    t.boolean "gender_equality", default: false, null: false
    t.boolean "clean_water_and_sanitation", default: false, null: false
    t.boolean "affordable_and_clean_energy", default: false, null: false
    t.boolean "descent_work_and_economic_growth", default: false, null: false
    t.boolean "industry_innovation_and_infrastructure", default: false, null: false
    t.boolean "reduced_inequalities", default: false, null: false
    t.boolean "sustainable_cities_and_conmmunities", default: false, null: false
    t.boolean "responsible_consumption_and_production", default: false, null: false
    t.boolean "climate_action", default: false, null: false
    t.boolean "life_below_water", default: false, null: false
    t.boolean "life_on_land", default: false, null: false
    t.boolean "peace_justice_and_strong_institutions", default: false, null: false
    t.boolean "partnerships_for_the_goals", default: false, null: false
    t.datetime "deleted_at"
    t.datetime "presentable_at"
    t.index ["loan_id"], name: "index_loan_sdg_data_on_loan_id"
  end

  create_table "loan_types", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "description"
    t.datetime "deleted_at"
    t.bigint "fund_id", null: false
    t.datetime "SysStartTime", precision: 7, default: -> { "sysutcdatetime()" }, null: false
    t.datetime "SysEndTime", precision: 7, default: '12-31-9999 23:59:59.9999999', null: false
    t.index ["deleted_at"], name: "index_loan_types_on_deleted_at"
    t.index ["fund_id"], name: "index_loan_types_on_fund_id"
  end

  create_table "loan_versions", force: :cascade do |t|
    t.bigint "loan_id", null: false
    t.integer "version_number", default: 1, null: false
    t.string "status", null: false
    t.string "version_status", default: "temporary", null: false
    t.bigint "currency_id"
    t.bigint "loan_type_id"
    t.bigint "repayment_type_id"
    t.bigint "creation_user_id", null: false
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
    t.boolean "in_waiting_list", default: false, null: false
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
    t.float "loan_spread"
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
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.date "deleted_at"
    t.bigint "executed_bond_id"
    t.bigint "pool_id"
    t.bigint "loan_interest_rate_type_id"
    t.string "hedge_comment", limit: 100
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
    t.datetime "SysStartTime", precision: 7, default: -> { "sysutcdatetime()" }, null: false
    t.datetime "SysEndTime", precision: 7, default: '12-31-9999 23:59:59.9999999', null: false
    t.bigint "approved_bond_id"
    t.bigint "approved_interest_rate_type_id"
    t.integer "number_of_disbursement_date_updates"
    t.decimal "invested_hedge_fx_rate", precision: 18, scale: 9
    t.datetime "presentable_at"
    t.float "hedge_spread"
    t.bigint "hedge_interest_rate_type_id"
    t.index ["creation_user_id"], name: "index_loan_versions_on_creation_user_id"
    t.index ["currency_id"], name: "index_loan_versions_on_currency_id"
    t.index ["executed_bond_id"], name: "index_loan_versions_on_executed_bond_id"
    t.index ["loan_id", "version_number"], name: "index_loan_versions_on_loan_id_and_version_number", unique: true
    t.index ["loan_id"], name: "index_loan_versions_on_loan_id"
    t.index ["loan_interest_rate_type_id"], name: "index_loan_versions_on_loan_interest_rate_type_id"
    t.index ["loan_type_id"], name: "index_loan_versions_on_loan_type_id"
    t.index ["pool_id"], name: "index_loan_versions_on_pool_id"
    t.index ["rejection_user_id"], name: "index_loan_versions_on_rejection_user_id"
    t.index ["repayment_type_id"], name: "index_loan_versions_on_repayment_type_id"
    t.index ["validation_user_id"], name: "index_loan_versions_on_validation_user_id"
  end

  create_table "loans", force: :cascade do |t|
    t.bigint "fund_id", null: false
    t.integer "innpact_loan_id", null: false
    t.bigint "institution_id"
    t.bigint "creation_user_id", null: false
    t.date "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "noval"
    t.string "institution_mode_at_creation", default: "new", null: false
    t.integer "last_loan_version", default: 0, null: false
    t.boolean "restructuring", default: false, null: false
    t.bigint "im_group_id"
    t.bigint "original_loan_id"
    t.datetime "copied_at"
    t.datetime "SysStartTime", precision: 7, default: -> { "sysutcdatetime()" }, null: false
    t.datetime "SysEndTime", precision: 7, default: '12-31-9999 23:59:59.9999999', null: false
    t.index ["creation_user_id"], name: "index_loans_on_creation_user_id"
    t.index ["fund_id"], name: "index_loans_on_fund_id"
    t.index ["im_group_id"], name: "index_loans_on_im_group_id"
    t.index ["innpact_loan_id"], name: "index_loans_on_innpact_loan_id", unique: true
    t.index ["institution_id"], name: "index_loans_on_institution_id"
  end

  create_table "pool_countries", force: :cascade do |t|
    t.bigint "pool_id", null: false
    t.bigint "country_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "deleted_at"
    t.datetime "SysStartTime", precision: 7, default: -> { "sysutcdatetime()" }, null: false
    t.datetime "SysEndTime", precision: 7, default: '12-31-9999 23:59:59.9999999', null: false
    t.index ["country_id"], name: "index_pool_countries_on_country_id"
    t.index ["deleted_at"], name: "index_pool_countries_on_deleted_at"
    t.index ["pool_id"], name: "index_pool_countries_on_pool_id"
  end

  create_table "pool_country_groups", force: :cascade do |t|
    t.bigint "pool_id", null: false
    t.bigint "country_group_id", null: false
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "SysStartTime", precision: 7, default: -> { "sysutcdatetime()" }, null: false
    t.datetime "SysEndTime", precision: 7, default: '12-31-9999 23:59:59.9999999', null: false
    t.index ["country_group_id"], name: "index_pool_country_groups_on_country_group_id"
    t.index ["pool_id"], name: "index_pool_country_groups_on_pool_id"
  end

  create_table "pool_currencies", force: :cascade do |t|
    t.bigint "pool_id", null: false
    t.bigint "currency_id", null: false
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "SysStartTime", precision: 7, default: -> { "sysutcdatetime()" }, null: false
    t.datetime "SysEndTime", precision: 7, default: '12-31-9999 23:59:59.9999999', null: false
    t.index ["currency_id"], name: "index_pool_currencies_on_currency_id"
    t.index ["pool_id"], name: "index_pool_currencies_on_pool_id"
  end

  create_table "pool_documents", force: :cascade do |t|
    t.bigint "pool_id", null: false
    t.string "document", null: false
    t.string "original_filename", null: false
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "slug", null: false
    t.datetime "SysStartTime", precision: 7, default: -> { "sysutcdatetime()" }, null: false
    t.datetime "SysEndTime", precision: 7, default: '12-31-9999 23:59:59.9999999', null: false
    t.index ["deleted_at"], name: "index_pool_documents_on_deleted_at"
    t.index ["pool_id"], name: "index_pool_documents_on_pool_id"
    t.index ["slug"], name: "index_pool_documents_on_slug", unique: true
  end

  create_table "pool_institution_groups", force: :cascade do |t|
    t.bigint "pool_id", null: false
    t.bigint "institution_group_id", null: false
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "SysStartTime", precision: 7, default: -> { "sysutcdatetime()" }, null: false
    t.datetime "SysEndTime", precision: 7, default: '12-31-9999 23:59:59.9999999', null: false
    t.index ["institution_group_id"], name: "index_pool_institution_groups_on_institution_group_id"
    t.index ["pool_id"], name: "index_pool_institution_groups_on_pool_id"
  end

  create_table "pool_institution_types", force: :cascade do |t|
    t.bigint "pool_id", null: false
    t.bigint "institution_type_id", null: false
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "SysStartTime", precision: 7, default: -> { "sysutcdatetime()" }, null: false
    t.datetime "SysEndTime", precision: 7, default: '12-31-9999 23:59:59.9999999', null: false
    t.index ["institution_type_id"], name: "index_pool_institution_types_on_institution_type_id"
    t.index ["pool_id"], name: "index_pool_institution_types_on_pool_id"
  end

  create_table "pool_institutions", force: :cascade do |t|
    t.bigint "pool_id", null: false
    t.bigint "institution_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "deleted_at"
    t.datetime "SysStartTime", precision: 7, default: -> { "sysutcdatetime()" }, null: false
    t.datetime "SysEndTime", precision: 7, default: '12-31-9999 23:59:59.9999999', null: false
    t.index ["deleted_at"], name: "index_pool_institutions_on_deleted_at"
    t.index ["institution_id"], name: "index_pool_institutions_on_institution_id"
    t.index ["pool_id"], name: "index_pool_institutions_on_pool_id"
  end

  create_table "pool_legal_documents", force: :cascade do |t|
    t.bigint "pool_id", null: false
    t.string "document", null: false
    t.string "original_filename", null: false
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "slug", null: false
    t.datetime "SysStartTime", precision: 7, default: -> { "sysutcdatetime()" }, null: false
    t.datetime "SysEndTime", precision: 7, default: '12-31-9999 23:59:59.9999999', null: false
    t.index ["pool_id"], name: "index_pool_legal_documents_on_pool_id"
    t.index ["slug"], name: "index_pool_legal_documents_on_slug", unique: true
  end

  create_table "pool_loan_types", force: :cascade do |t|
    t.bigint "pool_id", null: false
    t.bigint "loan_type_id", null: false
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "SysStartTime", precision: 7, default: -> { "sysutcdatetime()" }, null: false
    t.datetime "SysEndTime", precision: 7, default: '12-31-9999 23:59:59.9999999', null: false
    t.index ["loan_type_id"], name: "index_pool_loan_types_on_loan_type_id"
    t.index ["pool_id"], name: "index_pool_loan_types_on_pool_id"
  end

  create_table "pool_targets", force: :cascade do |t|
    t.decimal "amount_in_usd", precision: 17, scale: 2
    t.bigint "pool_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "deleted_at"
    t.decimal "amount_in_percent", precision: 5, scale: 2
    t.string "is_target_in_usd_or_percent", default: "USD", null: false
    t.datetime "SysStartTime", precision: 7, default: -> { "sysutcdatetime()" }, null: false
    t.datetime "SysEndTime", precision: 7, default: '12-31-9999 23:59:59.9999999', null: false
    t.index ["deleted_at"], name: "index_pool_targets_on_deleted_at"
    t.index ["pool_id"], name: "index_pool_targets_on_pool_id"
  end

  create_table "pools", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "deleted_at"
    t.date "subscription_date", default: -> { "getdate()" }, null: false
    t.boolean "has_maturity_date", default: false, null: false
    t.date "maturity_date"
    t.decimal "amount", precision: 17, scale: 2, default: 10.0, null: false
    t.bigint "currency_id", default: 3, null: false
    t.decimal "amount_in_usd", precision: 17, scale: 2, default: 12.0, null: false
    t.boolean "required_specific_reporting", default: false, null: false
    t.boolean "is_targeted", default: false, null: false
    t.bigint "fund_id", null: false
    t.datetime "SysStartTime", precision: 7, default: -> { "sysutcdatetime()" }, null: false
    t.datetime "SysEndTime", precision: 7, default: '12-31-9999 23:59:59.9999999', null: false
    t.index ["currency_id"], name: "index_pools_on_currency_id"
    t.index ["deleted_at"], name: "index_pools_on_deleted_at"
    t.index ["fund_id"], name: "index_pools_on_fund_id"
  end

  create_table "positive_impact_services_offereds", force: :cascade do |t|
    t.bigint "institution_id", null: false
    t.bigint "user_id"
    t.boolean "mobile_banking_services"
    t.integer "number_clients_using_mobile_banking"
    t.boolean "deposits"
    t.integer "number_clients_with_deposits"
    t.boolean "voluntary_savings"
    t.datetime "deleted_at"
    t.datetime "as_of", default: -> { "getdate()" }
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["institution_id"], name: "index_positive_impact_services_offereds_on_institution_id"
    t.index ["user_id"], name: "index_positive_impact_services_offereds_on_user_id"
  end

  create_table "presentation_compliance_checks", force: :cascade do |t|
    t.string "proposed_investment_complies_with_mef_guidelines"
    t.string "investee_microfinance_portfolio_greater_than_two_times_mef_loan"
    t.string "kyc_check"
    t.string "aml_risk_rate"
    t.string "aml_country_risk_assessment"
    t.string "tax_report_assessment"
    t.datetime "presentable_at"
    t.bigint "loan_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "deleted_at"
    t.index ["loan_id", "presentable_at"], name: "index_presentation_compliance_checks_on_loan_id_and_presentable_at"
    t.index ["loan_id"], name: "index_presentation_compliance_checks_on_loan_id"
  end

  create_table "repayment_calendar_lines", force: :cascade do |t|
    t.bigint "repayment_calendar_id", null: false
    t.date "repayment_date", null: false
    t.string "repayment_type", null: false
    t.decimal "original_amount", precision: 17, scale: 2, null: false
    t.decimal "received_amount", precision: 17, scale: 2, default: 0.0, null: false
    t.string "status", default: "pending", null: false
    t.decimal "provision", precision: 17, scale: 2, default: 0.0, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "previous_version_line_id"
    t.datetime "deleted_at"
    t.datetime "SysStartTime", precision: 7, default: -> { "sysutcdatetime()" }, null: false
    t.datetime "SysEndTime", precision: 7, default: '12-31-9999 23:59:59.9999999', null: false
    t.index ["previous_version_line_id"], name: "index_repayment_calendar_lines_on_previous_version_line_id"
    t.index ["repayment_calendar_id"], name: "index_repayment_calendar_lines_on_repayment_calendar_id"
  end

  create_table "repayment_calendars", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "creation_user_id", null: false
    t.string "version_status", default: "temporary", null: false
    t.bigint "validation_user_id"
    t.bigint "rejection_user_id"
    t.bigint "loan_version_id"
    t.datetime "deleted_at"
    t.datetime "SysStartTime", precision: 7, default: -> { "sysutcdatetime()" }, null: false
    t.datetime "SysEndTime", precision: 7, default: '12-31-9999 23:59:59.9999999', null: false
    t.index ["creation_user_id"], name: "index_repayment_calendars_on_creation_user_id"
    t.index ["loan_version_id"], name: "index_repayment_calendars_on_loan_version_id"
    t.index ["rejection_user_id"], name: "index_repayment_calendars_on_rejection_user_id"
    t.index ["validation_user_id"], name: "index_repayment_calendars_on_validation_user_id"
  end

  create_table "repayment_types", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "description"
    t.datetime "deleted_at"
    t.bigint "fund_id", null: false
    t.datetime "SysStartTime", precision: 7, default: -> { "sysutcdatetime()" }, null: false
    t.datetime "SysEndTime", precision: 7, default: '12-31-9999 23:59:59.9999999', null: false
    t.index ["deleted_at"], name: "index_repayment_types_on_deleted_at"
    t.index ["fund_id"], name: "index_repayment_types_on_fund_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.string "resource_type"
    t.bigint "resource_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "SysStartTime", precision: 7, default: -> { "sysutcdatetime()" }, null: false
    t.datetime "SysEndTime", precision: 7, default: '12-31-9999 23:59:59.9999999', null: false
    t.index ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id"
    t.index ["name"], name: "index_roles_on_name"
    t.index ["resource_type", "resource_id"], name: "index_roles_on_resource_type_and_resource_id"
  end

  create_table "statuses", force: :cascade do |t|
    t.string "name"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "description"
    t.datetime "deleted_at"
    t.bigint "fund_id", null: false
    t.datetime "SysStartTime", precision: 7, default: -> { "sysutcdatetime()" }, null: false
    t.datetime "SysEndTime", precision: 7, default: '12-31-9999 23:59:59.9999999', null: false
    t.index ["deleted_at"], name: "index_statuses_on_deleted_at"
    t.index ["fund_id"], name: "index_statuses_on_fund_id"
    t.index ["user_id"], name: "index_statuses_on_user_id"
  end

  create_table "user_settings", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.integer "loans_crud", default: 1, null: false
    t.integer "loans_validation", default: 1, null: false
    t.integer "provisions_crud", default: 1, null: false
    t.integer "provisions_validation", default: 1, null: false
    t.integer "repayments_crud", default: 1, null: false
    t.integer "repayments_validation", default: 1, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_user_settings_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer "invitation_limit"
    t.string "invited_by_type"
    t.bigint "invited_by_id"
    t.integer "invitations_count", default: 0
    t.string "firstname"
    t.string "lastname"
    t.datetime "deleted_at"
    t.string "phone_number"
    t.datetime "SysStartTime", precision: 7, default: -> { "sysutcdatetime()" }, null: false
    t.datetime "SysEndTime", precision: 7, default: '12-31-9999 23:59:59.9999999', null: false
    t.index ["deleted_at"], name: "index_users_on_deleted_at"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["invitation_token"], name: "index_users_on_invitation_token", unique: true, where: "([invitation_token] IS NOT NULL)"
    t.index ["invitations_count"], name: "index_users_on_invitations_count"
    t.index ["invited_by_id"], name: "index_users_on_invited_by_id"
    t.index ["invited_by_type", "invited_by_id"], name: "index_users_on_invited_by_type_and_invited_by_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, where: "([reset_password_token] IS NOT NULL)"
  end

  create_table "users_roles", id: false, force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "role_id"
    t.index ["role_id"], name: "index_users_roles_on_role_id"
    t.index ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id"
    t.index ["user_id"], name: "index_users_roles_on_user_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "additional_pais_environments", "users"
  add_foreign_key "additional_pais_socials", "users"
  add_foreign_key "bonds", "funds"
  add_foreign_key "calendar_log_lines", "repayment_calendar_lines", column: "new_repayment_line_id"
  add_foreign_key "calendar_log_lines", "repayment_calendar_lines", column: "original_repayment_line_id"
  add_foreign_key "calendar_logs", "users", column: "creation_user_id"
  add_foreign_key "countries", "country_groups", on_delete: :nullify
  add_foreign_key "countries", "funds"
  add_foreign_key "country_groups", "funds"
  add_foreign_key "currencies", "countries"
  add_foreign_key "currencies", "funds"
  add_foreign_key "currency_countries", "countries"
  add_foreign_key "currency_countries", "currencies"
  add_foreign_key "currency_rates", "currencies"
  add_foreign_key "dashboard_notifications", "users"
  add_foreign_key "default_limits", "funds"
  add_foreign_key "fund_usd_amounts", "funds"
  add_foreign_key "funds_users", "funds"
  add_foreign_key "funds_users", "users"
  add_foreign_key "institution_alinus_results", "users"
  add_foreign_key "institution_assets", "institutions"
  add_foreign_key "institution_covenants", "funds"
  add_foreign_key "institution_covenants", "institutions"
  add_foreign_key "institution_esg_gender_equalities", "users"
  add_foreign_key "institution_esg_pai_indicators", "users"
  add_foreign_key "institution_esg_risks", "users"
  add_foreign_key "institution_esg_safeguards", "users"
  add_foreign_key "institution_esg_sdg_contributions", "users"
  add_foreign_key "institution_financials", "users"
  add_foreign_key "institution_groups", "funds"
  add_foreign_key "institution_impact_indicators", "users"
  add_foreign_key "institution_liabilities", "institutions"
  add_foreign_key "institution_profiles", "users"
  add_foreign_key "institution_provisions", "users", column: "creation_user_id"
  add_foreign_key "institution_ratings", "users"
  add_foreign_key "institution_specific_breakdowns", "users"
  add_foreign_key "institution_types", "funds"
  add_foreign_key "institutions", "countries"
  add_foreign_key "institutions", "funds"
  add_foreign_key "institutions", "institution_groups"
  add_foreign_key "institutions", "institution_types"
  add_foreign_key "interest_rate_types", "funds"
  add_foreign_key "limit_exceptions", "funds"
  add_foreign_key "loan_provisions", "users", column: "creation_user_id"
  add_foreign_key "loan_requests", "currencies"
  add_foreign_key "loan_requests", "funds"
  add_foreign_key "loan_requests", "institutions"
  add_foreign_key "loan_requests", "loan_types"
  add_foreign_key "loan_requests", "repayment_types"
  add_foreign_key "loan_requests", "users"
  add_foreign_key "loan_requests", "users", column: "assigned_investment_manager_id"
  add_foreign_key "loan_sdg_data", "loans"
  add_foreign_key "loan_types", "funds"
  add_foreign_key "loan_versions", "currencies"
  add_foreign_key "loan_versions", "loan_types"
  add_foreign_key "loan_versions", "repayment_types"
  add_foreign_key "loan_versions", "users", column: "creation_user_id"
  add_foreign_key "loan_versions", "users", column: "rejection_user_id"
  add_foreign_key "loan_versions", "users", column: "validation_user_id"
  add_foreign_key "loans", "funds"
  add_foreign_key "loans", "institutions"
  add_foreign_key "loans", "users", column: "creation_user_id"
  add_foreign_key "pool_countries", "countries"
  add_foreign_key "pool_countries", "pools"
  add_foreign_key "pool_country_groups", "country_groups"
  add_foreign_key "pool_country_groups", "pools"
  add_foreign_key "pool_currencies", "currencies"
  add_foreign_key "pool_currencies", "pools"
  add_foreign_key "pool_documents", "pools"
  add_foreign_key "pool_institution_groups", "institution_groups"
  add_foreign_key "pool_institution_groups", "pools"
  add_foreign_key "pool_institution_types", "institution_types"
  add_foreign_key "pool_institution_types", "pools"
  add_foreign_key "pool_institutions", "institutions"
  add_foreign_key "pool_institutions", "pools"
  add_foreign_key "pool_legal_documents", "pools"
  add_foreign_key "pool_loan_types", "loan_types"
  add_foreign_key "pool_loan_types", "pools"
  add_foreign_key "pool_targets", "pools"
  add_foreign_key "pools", "currencies"
  add_foreign_key "pools", "funds"
  add_foreign_key "positive_impact_services_offereds", "users"
  add_foreign_key "presentation_compliance_checks", "loans"
  add_foreign_key "repayment_calendar_lines", "repayment_calendar_lines", column: "previous_version_line_id"
  add_foreign_key "repayment_calendars", "users", column: "creation_user_id"
  add_foreign_key "repayment_calendars", "users", column: "rejection_user_id"
  add_foreign_key "repayment_calendars", "users", column: "validation_user_id"
  add_foreign_key "repayment_types", "funds"
  add_foreign_key "statuses", "funds"
  add_foreign_key "statuses", "users"
  add_foreign_key "user_settings", "users"

  create_view "cash_flows", sql_definition: <<-SQL
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
				AND loan_versions.version_number = loans.last_loan_version;
  SQL
  create_view "v_institutions_covenants", sql_definition: <<-SQL
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
				AND institution_covenants.deleted_at IS NULL;
  SQL
  create_view "count_number_of_rows_in_archive_views", sql_definition: <<-SQL
    		with institutions_archive_count as (
			select 'intistutions archive' as archive, data_viewed_at, count(*) as rows_count
			from archive_v_institutions
			group by data_viewed_at
		), institution_covenants_archive_count as (
			select 'institution covenants archive' as archive, data_viewed_at, count(*)  as rows_count
			from archive_v_institutions_covenants avic  
			group by data_viewed_at
		), loans_archive_count as (
			select 'loans archive' as archive, data_viewed_at, count(*)  as rows_count
			from archive_v_loans avl 
			group by data_viewed_at
		), cash_flow_archive_count as (
			select 'cash flow archive' as archive, data_viewed_at, count(*) as rows_count
			from archive_cash_flows acf 
			group by data_viewed_at
		), additional_pais_socials_archive_count as (
			select 'additional pais socials archive' as archive, data_viewed_at, count(*) as rows_count
			from archive_v_additional_pai_socials acf 
			group by data_viewed_at
		), additional_pais_environments_archive_count as (
			select 'additional pais environments archive' as archive, data_viewed_at, count(*) as rows_count
			from archive_v_additional_pai_environments acf 
			group by data_viewed_at
		) select * from (
			select * from institutions_archive_count
			union all
			select * from institution_covenants_archive_count
			union all
			select * from loans_archive_count
			union all
			select * from cash_flow_archive_count
			union all
			select * from additional_pais_socials_archive_count
			union all
			select * from additional_pais_environments_archive_count
		) archive;
		;
  SQL
  create_view "v_additional_pai_socials", sql_definition: <<-SQL
      WITH 
  max_additional_pais_socials_by_as_of AS (
      SELECT institution_id, social_pai_reported, MAX(as_of) AS max_as_of
      FROM additional_pais_socials
      WHERE deleted_at IS NULL
      GROUP BY institution_id, social_pai_reported
  ),
  max_additional_pais_socials_by_updated_at AS (
      SELECT additional_pais_socials.institution_id, additional_pais_socials.social_pai_reported, updated_at AS max_updated_at, as_of, social_pai_value
      FROM additional_pais_socials
  		JOIN max_additional_pais_socials_by_as_of ON max_additional_pais_socials_by_as_of.max_as_of = additional_pais_socials.as_of 
  		AND max_additional_pais_socials_by_as_of.institution_id = additional_pais_socials.institution_id
  		AND max_additional_pais_socials_by_as_of.social_pai_reported = additional_pais_socials.social_pai_reported
      WHERE deleted_at IS NULL 
  ),
  filtered_additional_pais_socials AS(
  	SELECT max_additional_pais_socials_by_updated_at.institution_id, max_additional_pais_socials_by_updated_at.social_pai_reported, max_additional_pais_socials_by_updated_at.as_of, MAX(max_additional_pais_socials_by_updated_at.max_updated_at) AS max_updated_at
  	FROM max_additional_pais_socials_by_updated_at
  	GROUP BY max_additional_pais_socials_by_updated_at.institution_id, max_additional_pais_socials_by_updated_at.social_pai_reported, max_additional_pais_socials_by_updated_at.as_of
  )

  SELECT 
  	institutions.id AS institution_id,
      institutions.name AS institution_name,

      /* additional_pais_socials */
      additional_pais_socials.as_of AS pais_social_as_of,
      additional_pais_socials.social_pai_reported,
      additional_pais_socials.social_pai_value,
      GETDATE() As data_viewed_at
  FROM filtered_additional_pais_socials
  	JOIN additional_pais_socials ON additional_pais_socials.as_of = filtered_additional_pais_socials.as_of
  	AND additional_pais_socials.updated_at = filtered_additional_pais_socials.max_updated_at
  	AND additional_pais_socials.social_pai_reported = filtered_additional_pais_socials.social_pai_reported
  	AND additional_pais_socials.institution_id = filtered_additional_pais_socials.institution_id
  	JOIN institutions ON institutions.id = filtered_additional_pais_socials.institution_id
  WHERE 
  institutions.deleted_at IS NULL;
  SQL
  create_view "v_additional_pai_environments", sql_definition: <<-SQL
      WITH 
  max_additional_pais_environments_by_as_of AS (
      SELECT institution_id, environment_pai_reported, MAX(as_of) AS max_as_of
      FROM additional_pais_environments
      WHERE deleted_at IS NULL
      GROUP BY institution_id, environment_pai_reported
  ),
  max_additional_pais_environments_by_updated_at AS (
      SELECT additional_pais_environments.institution_id, additional_pais_environments.environment_pai_reported, updated_at AS max_updated_at, as_of, environment_pai_value
      FROM additional_pais_environments
  		JOIN max_additional_pais_environments_by_as_of ON max_additional_pais_environments_by_as_of.max_as_of = additional_pais_environments.as_of 
  		AND max_additional_pais_environments_by_as_of.institution_id = additional_pais_environments.institution_id
  		AND max_additional_pais_environments_by_as_of.environment_pai_reported = additional_pais_environments.environment_pai_reported
      WHERE deleted_at IS NULL 
  ),
  filtered_additional_pais_environments AS(
  	SELECT max_additional_pais_environments_by_updated_at.institution_id, max_additional_pais_environments_by_updated_at.environment_pai_reported, max_additional_pais_environments_by_updated_at.as_of, MAX(max_additional_pais_environments_by_updated_at.max_updated_at) AS max_updated_at
  	FROM max_additional_pais_environments_by_updated_at
  	GROUP BY max_additional_pais_environments_by_updated_at.institution_id, max_additional_pais_environments_by_updated_at.environment_pai_reported, max_additional_pais_environments_by_updated_at.as_of
  )

  SELECT 
  	institutions.id AS institution_id,
      institutions.name AS institution_name,

      /* additional_pais_environments */
      additional_pais_environments.as_of AS pais_environment_as_of,
      additional_pais_environments.environment_pai_reported,
      additional_pais_environments.environment_pai_value,
      GETDATE() As data_viewed_at
  FROM filtered_additional_pais_environments
  	JOIN additional_pais_environments ON additional_pais_environments.as_of = filtered_additional_pais_environments.as_of
  	AND additional_pais_environments.updated_at = filtered_additional_pais_environments.max_updated_at
  	AND additional_pais_environments.environment_pai_reported = filtered_additional_pais_environments.environment_pai_reported
  	AND additional_pais_environments.institution_id = filtered_additional_pais_environments.institution_id
  	JOIN institutions ON institutions.id = filtered_additional_pais_environments.institution_id
  WHERE 
  institutions.deleted_at IS NULL;
  SQL
  create_view "v_institutions", sql_definition: <<-SQL
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
  ;
  SQL
  create_view "v_loans", sql_definition: <<-SQL
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
			loan_versions.loan_spread,
			coalesce(loan_versions.hedge_spread, loan_versions.loan_spread) as executed_spread,
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
			loan_versions.loan_interest_rate_type_id,
			coalesce(loan_versions.hedge_interest_rate_type_id, loan_versions.loan_interest_rate_type_id) as executed_interest_rate_type_id,
			loan_versions.hedge_comment,
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
		    loan_versions.hedge_spread,
		    loan_versions.hedge_interest_rate_type_id,
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
			LEFT JOIN loan_types ON funds.id = loan_types.fund_id
				AND loan_types.id = loan_versions.loan_type_id
			LEFT JOIN interest_rate_types ON interest_rate_types.fund_id = funds.id
				 AND interest_rate_types.id = loan_versions.loan_interest_rate_type_id
			LEFT JOIN currencies ON currencies.fund_id = funds.id
				 AND currencies.id = loan_versions.currency_id
			LEFT JOIN currency_rates ON currency_rates.currency_id = currencies.id
			LEFT JOIN repayment_types ON repayment_types.fund_id = funds.id
				 AND repayment_types.id = loan_versions.repayment_type_id
			LEFT JOIN bonds ON bonds.fund_id = funds.id
				 AND bonds.id = loan_versions.executed_bond_id
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
		;
  SQL
end
