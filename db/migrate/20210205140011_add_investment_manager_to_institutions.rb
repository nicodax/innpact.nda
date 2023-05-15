class AddInvestmentManagerToInstitutions < ActiveRecord::Migration[6.0]
  def change
    add_reference :institutions, :investment_manager, foreign_key: { to_table: :users }
  end
end
