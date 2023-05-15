# frozen_string_literal: true

class UpdateVLoansToVersion8 < ActiveRecord::Migration[6.0]
  def change
    update_view :v_loans, version: 8, revert_to_version: 7
  end
end