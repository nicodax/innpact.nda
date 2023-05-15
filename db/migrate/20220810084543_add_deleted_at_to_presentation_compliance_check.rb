# frozen_string_literal: true

class AddDeletedAtToPresentationComplianceCheck < ActiveRecord::Migration[6.0]
  def change
    add_column :presentation_compliance_checks, :deleted_at, :datetime
  end
end
