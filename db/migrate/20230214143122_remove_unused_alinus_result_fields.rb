class RemoveUnusedAlinusResultFields < ActiveRecord::Migration[6.0]
  def change
    remove_column :institution_alinus_results, :has_sptf_alinus_reporting_using_alinus, :boolean
    remove_column :institution_alinus_results, :sptf_alinus_reporting_using_alinus, :string
  end
end
