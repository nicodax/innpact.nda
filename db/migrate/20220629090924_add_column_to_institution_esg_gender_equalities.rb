class AddColumnToInstitutionEsgGenderEqualities < ActiveRecord::Migration[6.0]
  def up
    add_column :institution_esg_gender_equalities, :training_on_responsible_finance_targeting_women, :boolean, default: false, null: false
    add_column :institution_esg_gender_equalities, :women_percentage_in_management, :decimal, precision: 5, scale: 2, default: 0, null: false
  end
  def down 
    remove_column :institution_esg_gender_equalities, :training_on_responsible_finance_targeting_women
    remove_column :institution_esg_gender_equalities, :women_percentage_in_management
  end
end
