class FillEmptyFieldsForApprovedStatus < ActiveRecord::Migration[6.0]
  def up
    Rake::Task['fill_approved_bond_and_interest_type:fill'].invoke
  end
end
