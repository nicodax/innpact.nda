class CreateInstitutionEsgGenderEqualities < ActiveRecord::Migration[6.0]
  def up
    create_table :institution_esg_gender_equalities do |t|
      t.references :institution, null: false
      t.decimal :women_percentage_in_board, precision: 5, scale: 2, null: false
      t.decimal :women_percentage_in_staff, precision: 5, scale: 2, null: false
      t.boolean :financial_services_targeting_women, null: false, default: false
      t.boolean :non_financial_services_targeting_women, null: false, default: false
      t.datetime :deleted_at
      t.datetime :as_of, default: DateTime.now
      
      t.timestamps
    end
  end
  def down
    drop_table :institution_esg_gender_equalities
  end
end
