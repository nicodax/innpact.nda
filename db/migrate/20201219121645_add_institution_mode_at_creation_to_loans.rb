class AddInstitutionModeAtCreationToLoans < ActiveRecord::Migration[6.0]
  def change
    add_column :loans, :institution_mode_at_creation, :string, default: 'new', null: false
  end
end
