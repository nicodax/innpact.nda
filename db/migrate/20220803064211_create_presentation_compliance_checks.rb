class CreatePresentationComplianceChecks < ActiveRecord::Migration[6.0]
  def change
    create_table :presentation_compliance_checks do |t|
      t.string :proposed_investment_complies_with_mef_guidelines
      t.string :investee_microfinance_portfolio_greater_than_two_times_mef_loan
      t.string :kyc_check
      t.string :aml_risk_rate
      t.string :aml_country_risk_assessment
      t.string :tax_report_assessment
      t.datetime :presentable_at
      t.belongs_to :loan, null: false, foreign_key: true

      t.timestamps
    end
    add_index :presentation_compliance_checks, [:loan_id, :presentable_at]
  end
end
