class UpdateVLoansToVersion11 < ActiveRecord::Migration[6.0]
  def change
    update_view :v_loans, version: 11, revert_to_version: 10
  end
end
