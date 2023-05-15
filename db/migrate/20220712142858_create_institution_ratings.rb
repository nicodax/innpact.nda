class CreateInstitutionRatings < ActiveRecord::Migration[6.0]
  def up
    create_table :institution_ratings do |t|
      t.references :institution, null: false
      t.references :user, foreign_key: true
      t.string :external_rating
      t.string :external_rating_agency
      t.string :internal_credit_risk_rating
      t.decimal :probability_of_default, precision: 18
      t.datetime :deleted_at
      t.datetime :as_of, default: -> { 'CURRENT_TIMESTAMP' }
      t.timestamps
    end
  end
  def down
    drop_table :institution_ratings
  end
end
