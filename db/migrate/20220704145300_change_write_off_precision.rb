class ChangeWriteOffPrecision < ActiveRecord::Migration[6.0]
  def up
    change_column :institutions, :write_off, :decimal, precision: 5, scale: 2
    change_column :archive_v_institutions, :write_off, :decimal, precision: 5, scale: 2
  end
  def down
    change_column :institutions, :write_off, :decimal, precision: 18, scale: 2
    change_column :archive_v_institutions, :write_off, :decimal, precision: 18, scale: 2
  end
end
