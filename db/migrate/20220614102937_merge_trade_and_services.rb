class MergeTradeAndServices < ActiveRecord::Migration[6.0]
  def up
    Rake::Task['trade_and_services:merge'].invoke
  end
end
