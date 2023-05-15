class CreateCashFlows < ActiveRecord::Migration[6.0]
  def change
    create_view :cash_flows
  end
end
