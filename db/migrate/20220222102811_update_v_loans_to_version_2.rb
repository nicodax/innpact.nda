class UpdateVLoansToVersion2 < ActiveRecord::Migration[6.0]
  def change
    update_view :v_loans, version: 2, revert_to_version: 1
  end
end
