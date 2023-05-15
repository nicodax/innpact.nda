class AddDeletedAddOnReferentials < ActiveRecord::Migration[6.0]
  def change
    add_column :countries, :deleted_at, :datetime
    add_column :default_limits, :deleted_at, :datetime
    add_column :limit_exceptions, :deleted_at, :datetime
    add_column :loan_types, :deleted_at, :datetime
    add_column :mfis, :deleted_at, :datetime
    add_column :mfi_groups, :deleted_at, :datetime
    add_column :regions, :deleted_at, :datetime
    add_column :repayment_types, :deleted_at, :datetime
    add_column :statuses, :deleted_at, :datetime

    add_index :countries, :deleted_at
    add_index :default_limits, :deleted_at
    add_index :limit_exceptions, :deleted_at
    add_index :loan_types, :deleted_at
    add_index :mfis, :deleted_at
    add_index :mfi_groups, :deleted_at
    add_index :regions, :deleted_at
    add_index :repayment_types, :deleted_at
    add_index :statuses, :deleted_at
  end
end
