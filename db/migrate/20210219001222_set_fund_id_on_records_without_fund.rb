class SetFundIdOnRecordsWithoutFund < ActiveRecord::Migration[6.0]
  def up
    # We need to drop indexes which are set in the previous migration and recreate after change_column
    # modification
    remove_index :countries, :fund_id
    remove_index :institution_types, :fund_id
    remove_index :institutions, :fund_id
    remove_index :institution_groups, :fund_id

    change_column :countries, :fund_id, :bigint, null: false
    change_column :country_groups, :fund_id, :bigint, null: false
    change_column :institutions, :fund_id, :bigint, null: false
    change_column :currencies, :fund_id, :bigint, null: false
    change_column :default_limits, :fund_id, :bigint, null: false
    change_column :limit_exceptions, :fund_id, :bigint, null: false
    change_column :loan_types, :fund_id, :bigint, null: false
    change_column :pools, :fund_id, :bigint, null: false
    change_column :repayment_types, :fund_id, :bigint, null: false
    change_column :statuses, :fund_id, :bigint, null: false
    change_column :institution_groups, :fund_id, :bigint, null: false
    change_column :institution_types, :fund_id, :bigint, null: false
    change_column :interest_rate_types, :fund_id, :bigint, null: false
    change_column :institution_covenants, :fund_id, :bigint, null: false

    add_index :countries, :fund_id
    add_index :institutions, :fund_id
    add_index :institution_groups, :fund_id
    add_index :institution_types, :fund_id
  end

  def down
    change_column :countries, :fund_id, :bigint, null: true
    change_column :country_groups, :fund_id, :bigint, null: true
    change_column :institutions, :fund_id, :bigint, null: true
    change_column :currencies, :fund_id, :bigint, null: true
    change_column :default_limits, :fund_id, :bigint, null: true
    change_column :limit_exceptions, :fund_id, :bigint, null: true
    change_column :loan_types, :fund_id, :bigint, null: true
    change_column :pools, :fund_id, :bigint, null: true
    change_column :repayment_types, :fund_id, :bigint, null: true
    change_column :statuses, :fund_id, :bigint, null: true
    change_column :institution_groups, :fund_id, :bigint, null: true
    change_column :institution_types, :fund_id, :bigint, null: true
    change_column :interest_rate_types, :fund_id, :bigint, null: true
    change_column :institution_covenants, :fund_id, :bigint, null: true
  end
end
