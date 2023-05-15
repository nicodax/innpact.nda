class ChangeInstitutionCovenantSettings < ActiveRecord::Migration[6.0]
  def change
    change_column :institution_covenants, :par30,  :decimal, precision: 8, scale: 4
    change_column :institution_covenants, :par30_limit, :decimal, precision: 8, scale: 4
    change_column :institution_covenants, :par30_refy, :decimal, precision: 8, scale: 4
    change_column :institution_covenants, :par30_refy_limit, :decimal, precision: 8, scale: 4
    change_column :institution_covenants, :roa, :decimal, precision: 8, scale: 4
    change_column :institution_covenants, :roa_limit, :decimal, precision: 8, scale: 4
    change_column :institution_covenants, :adj_roa, :decimal, precision: 8, scale: 4
    change_column :institution_covenants, :adj_roa_limit, :decimal, precision: 8, scale: 4
    change_column :institution_covenants, :open_fx_exposure, :decimal, precision: 8, scale: 4
    change_column :institution_covenants, :open_fx_exposure_limit, :decimal, precision: 8, scale: 4
    change_column :institution_covenants, :open_loan_position, :decimal, precision: 8, scale: 4
    change_column :institution_covenants, :open_loan_position_limit, :decimal, precision: 8, scale: 4
    change_column :institution_covenants, :car, :decimal, precision: 8, scale: 4
    change_column :institution_covenants, :car_limit, :decimal, precision: 8, scale: 4
    change_column :institution_covenants, :deposits_liabilities, :decimal, precision: 8, scale: 4
    change_column :institution_covenants, :deposits_liabilities_limit, :decimal, precision: 8, scale: 4
    change_column :institution_covenants, :maturity_matching_if_applicable, :decimal, precision: 8, scale: 4
    change_column :institution_covenants, :maturity_matching_if_applicable_limit, :decimal, precision: 8, scale: 4
    change_column :institution_covenants, :liquid_assets_deposits_if_applicable, :decimal, precision: 8, scale: 4
    change_column :institution_covenants, :liquid_assets_deposits_if_applicable_limit, :decimal, precision: 8, scale: 4
  end
end
