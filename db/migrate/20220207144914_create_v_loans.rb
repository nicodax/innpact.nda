class CreateVLoans < ActiveRecord::Migration[6.0]
  def change
    create_view :v_loans
  end
end
