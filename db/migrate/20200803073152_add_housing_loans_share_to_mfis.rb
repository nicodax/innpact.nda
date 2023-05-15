class AddHousingLoansShareToMfis < ActiveRecord::Migration[6.0]
  def change
    add_column :mfis, :housing_loans_share, :integer
  end
end
