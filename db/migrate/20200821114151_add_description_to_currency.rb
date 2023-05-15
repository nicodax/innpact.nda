class AddDescriptionToCurrency < ActiveRecord::Migration[6.0]
  def change
    add_column :currencies, :description, :string
  end
end
