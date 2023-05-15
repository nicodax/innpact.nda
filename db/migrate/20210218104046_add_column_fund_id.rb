class AddColumnFundId < ActiveRecord::Migration[6.0]
  def change
    add_reference :countries, :fund, index: true, foreign_key: true
    add_reference :country_groups, :fund, index: true, foreign_key: true
    add_reference :institutions, :fund, index: true, foreign_key: true
    add_reference :currencies, :fund, index: true, foreign_key: true
    add_reference :default_limits, :fund, index: true, foreign_key: true
    add_reference :limit_exceptions, :fund, index: true, foreign_key: true
    add_reference :loan_types, :fund, index: true, foreign_key: true
    add_reference :pools, :fund, index: true, foreign_key: true
    add_reference :repayment_types, :fund, index: true, foreign_key: true
    add_reference :statuses, :fund, index: true, foreign_key: true
    add_reference :bonds, :fund, index: true, foreign_key: true
    add_reference :institution_groups, :fund, index: true, foreign_key: true
    add_reference :institution_types, :fund, index: true, foreign_key: true
    add_reference :interest_rate_types, :fund, index: true, foreign_key: true
    add_reference :institution_covenants, :fund, index: true, foreign_key: true
  end
end
