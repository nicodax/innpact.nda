class AddImpactIndicatorsFields < ActiveRecord::Migration[6.0]
  def change
    add_column :institutions, :internal_impact_score, :string
    add_column :institutions, :number_of_clients, :integer
    add_column :institutions, :mobile_banking_percentage, :decimal, precision: 5, scale: 2
  end
end
