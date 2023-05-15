class AddColumnToPoolTargets < ActiveRecord::Migration[6.0]
  def change
    add_column :pool_targets, :is_target_in_usd_or_percent, :string, default: 'USD', null: false
  end
end
