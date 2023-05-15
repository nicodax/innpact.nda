class AddCountryRequirements < ActiveRecord::Migration[6.0]
  def change
    add_column :countries, :iso_code, :string
    add_column :countries, :population, :integer
    add_column :countries, :rating, :string
    add_column :countries, :gdp, :decimal, precision: 17, scale: 2
    add_column :countries, :gdp_per_capita, :decimal, precision: 17, scale: 2
    add_column :countries, :gni, :decimal, precision: 17, scale: 2
    add_column :countries, :gni_per_capita, :decimal, precision: 17, scale: 2
    add_column :countries, :mimosa_score, :integer
    add_column :countries, :is_a_high_income_country, :boolean
  end
end
