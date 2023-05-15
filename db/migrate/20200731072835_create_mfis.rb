class CreateMfis < ActiveRecord::Migration[6.0]
  def change
    create_table :mfis do |t|
      t.string :name
      t.belongs_to :country, null: false, foreign_key: true
      t.belongs_to :mfi_group, null: false, foreign_key: true
      t.string :institution_type
      t.string :gross_loan_portfolio
      t.string :portfolio_3y_ago
      t.integer :mf_portfolio_size
      t.integer :sme_portfolio_size
      t.integer :borrowers_count
      t.integer :f_borrowers_count
      t.integer :m_borrowers_count
      t.integer :rural_borrowers_count
      t.integer :consumer_loans_share
      t.integer :agriculture_loans_share
      t.integer :education_loans_share
      t.integer :trade_loans_share
      t.integer :avg_loan_size
      t.string :total_assets
      t.string :equity
      t.string :debt
      t.integer :deposits
      t.string :other_liabilities
      t.string :net_income
      t.string :internal_rating
      t.string :external_rating
      t.integer :tier

      t.timestamps
    end
  end
end
