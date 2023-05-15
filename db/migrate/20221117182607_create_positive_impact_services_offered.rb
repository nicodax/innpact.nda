class CreatePositiveImpactServicesOffered < ActiveRecord::Migration[6.0]
  def up
    create_table :positive_impact_services_offereds do |t|
      t.references :institution, null: false
      t.references :user, foreign_key: true
      t.boolean :mobile_banking_services
      t.integer :number_clients_using_mobile_banking
      t.boolean :deposits
      t.integer :number_clients_with_deposits
      t.boolean :voluntary_savings
      t.datetime :deleted_at
      t.datetime :as_of, default: -> { 'CURRENT_TIMESTAMP' }
      t.timestamps
    end
  end
  def down
    drop_table :positive_impact_services_offereds
  end
end
