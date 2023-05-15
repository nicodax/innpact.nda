class CreateVInstitutionsCovenants < ActiveRecord::Migration[6.0]
  def change
    create_view :v_institutions_covenants
  end
end
