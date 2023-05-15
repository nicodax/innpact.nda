class AddInternalCreditRiskRating < ActiveRecord::Migration[6.0]
  def change
    add_column :institutions, :internal_credit_risk_rating, :string
    add_column :archive_v_institutions, :internal_credit_risk_rating, :string
  end
end
