class AddFieldsToArchiveVLoan < ActiveRecord::Migration[6.0]
  def change
    add_column :archive_v_loans, :presentable, :string
    add_column :archive_v_loans, :presentable_at, :datetime
    add_column :archive_v_loans, :sdg_goal_01, :boolean
    add_column :archive_v_loans, :sdg_goal_02, :boolean
    add_column :archive_v_loans, :sdg_goal_03, :boolean
    add_column :archive_v_loans, :sdg_goal_04, :boolean
    add_column :archive_v_loans, :sdg_goal_05, :boolean
    add_column :archive_v_loans, :sdg_goal_06, :boolean
    add_column :archive_v_loans, :sdg_goal_07, :boolean
    add_column :archive_v_loans, :sdg_goal_08, :boolean
    add_column :archive_v_loans, :sdg_goal_09, :boolean
    add_column :archive_v_loans, :sdg_goal_10, :boolean
    add_column :archive_v_loans, :sdg_goal_11, :boolean
    add_column :archive_v_loans, :sdg_goal_12, :boolean
    add_column :archive_v_loans, :sdg_goal_13, :boolean
    add_column :archive_v_loans, :sdg_goal_14, :boolean
    add_column :archive_v_loans, :sdg_goal_15, :boolean
    add_column :archive_v_loans, :sdg_goal_16, :boolean
    add_column :archive_v_loans, :sdg_goal_17, :boolean
    add_column :archive_v_loans, :proposed_investment_complies_with_mef_guidelines, :string
    add_column :archive_v_loans, :investee_microfinance_portfolio_greater_than_two_times_mef_loan, :string
    add_column :archive_v_loans, :kyc_check, :string
    add_column :archive_v_loans, :aml_risk_rate, :string
    add_column :archive_v_loans, :aml_country_risk_assessment, :string
    add_column :archive_v_loans, :tax_report_assessment, :string
  end
end
