class CreateVInstitutions < ActiveRecord::Migration[6.0]
  def change
    create_view :v_institutions
  end
end
