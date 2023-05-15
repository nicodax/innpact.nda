class AddDescriptionToLimits < ActiveRecord::Migration[6.0]
  def change
    add_column :limit_exceptions, :description, :string
    add_column :default_limits, :description, :string
  end
end
