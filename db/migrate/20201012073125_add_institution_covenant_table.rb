class AddInstitutionCovenantTable < ActiveRecord::Migration[6.0]
  def change
    create_table :institution_covenants do |t|
      t.references :institution, foreign_key: true, null: false
      t.string :name
      t.decimal :par30, precision: 5, scale: 2
      t.decimal :par30_limit, precision: 5, scale: 2
      t.decimal :par30_refy, precision: 5, scale: 2
      t.decimal :par30_refy_limit, precision: 5, scale: 2
      t.decimal :roa, precision: 5, scale: 2
      t.decimal :roa_limit, precision: 5, scale: 2
      t.decimal :adj_roa, precision: 5, scale: 2
      t.decimal :adj_roa_limit, precision: 5, scale: 2
      t.decimal :open_fx_exposure, precision: 5, scale: 2
      t.decimal :open_fx_exposure_limit, precision: 5, scale: 2
      t.decimal :open_loan_position, precision: 5, scale: 2
      t.decimal :open_loan_position_limit, precision: 5, scale: 2
      t.decimal :car, precision: 5, scale: 2
      t.decimal :car_limit, precision: 5, scale: 2
      t.decimal :deposits_liabilities, precision: 5, scale: 2
      t.decimal :deposits_liabilities_limit, precision: 5, scale: 2
      t.decimal :maturity_matching_if_applicable, precision: 5, scale: 2
      t.decimal :maturity_matching_if_applicable_limit, precision: 5, scale: 2
      t.decimal :liquid_assets_deposits_if_applicable, precision: 5, scale: 2
      t.decimal :liquid_assets_deposits_if_applicable_limit, precision: 5, scale: 2

      t.datetime :deleted_at
      t.timestamps
    end
  end
end
