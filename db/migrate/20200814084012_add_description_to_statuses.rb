class AddDescriptionToStatuses < ActiveRecord::Migration[6.0]
  def change
    add_column :statuses, :description, :string
  end
end
