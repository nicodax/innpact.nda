class AddNotNullValidationOnFundName < ActiveRecord::Migration[6.0]
  def up
    Fund.all.each { |f| f.update(name: "fund_#{SecureRandom.uuid}") if f.name.blank? }
    change_column :funds, :name, :string, null: false
  end

  def down
    change_column :funds, :name, :string, null: true
  end
end
