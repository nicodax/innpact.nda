class RefactorDefaultTimestampAsOf < ActiveRecord::Migration[6.0]
  def up
    change_column :institution_esg_gender_equalities, :as_of, :datetime, default: -> { 'CURRENT_TIMESTAMP' }
    change_column :institution_esg_safeguards, :as_of, :datetime, default: -> { 'CURRENT_TIMESTAMP' }
    change_column :institution_esg_risks, :as_of, :datetime, default: -> { 'CURRENT_TIMESTAMP' }
    change_column :institution_esg_pai_indicators, :as_of, :datetime, default: -> { 'CURRENT_TIMESTAMP' }
    change_column :institution_esg_sdg_contributions, :as_of, :datetime, default: -> { 'CURRENT_TIMESTAMP' }
  end
  def down
    change_column :institution_esg_gender_equalities, :as_of, :datetime, default: DateTime.now
    change_column :institution_esg_safeguards, :as_of, :datetime, default: DateTime.now
    change_column :institution_esg_risks, :as_of, :datetime, default: DateTime.now
    change_column :institution_esg_pai_indicators, :as_of, :datetime, default: DateTime.now
    change_column :institution_esg_sdg_contributions, :as_of, :datetime, default: DateTime.now
  end
end
