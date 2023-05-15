class AddPresentableAtToLoanSdgData < ActiveRecord::Migration[6.0]
  def change
    add_column :loan_sdg_data, :presentable_at, :datetime
  end
end
