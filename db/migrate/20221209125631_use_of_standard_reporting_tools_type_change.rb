class UseOfStandardReportingToolsTypeChange < ActiveRecord::Migration[6.0]
  def change
    rename_column :institutions, :use_of_standard_reporting_tools, :use_of_standard_reporting_tools_boolean
    add_column :institutions, :use_of_standard_reporting_tools, :string
  end
end
