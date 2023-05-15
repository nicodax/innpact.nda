class AddSwapLinkToLoanRequest < ActiveRecord::Migration[6.0]
  def change
    add_column :loan_requests, :swap_link, :string
  end
end
