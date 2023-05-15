class AddNotNullToInstitutionAssetsLiabilities < ActiveRecord::Migration[6.0]
  def change
    change_column :institution_assets, :date, :datetime, null: false
    change_column :institution_assets, :amount, :decimal, null: false
    change_column :institution_liabilities, :date, :datetime, null: false
    change_column :institution_liabilities, :amount, :decimal, null: false
  end
end
