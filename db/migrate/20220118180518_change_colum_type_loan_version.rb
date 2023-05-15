class ChangeColumTypeLoanVersion < ActiveRecord::Migration[6.0]
  def change
    change_column :loan_versions, :pending_ratification_comment, :text
    change_column :loan_versions, :ratified_comment, :text
    change_column :loan_versions, :not_ratified_comment, :text
    change_column :loan_versions, :assignement_expired_comment, :text
    change_column :loan_versions, :released_before_approval_comment, :text
    change_column :loan_versions, :pending_approval_comment, :text
    change_column :loan_versions, :approved_comment, :text
    change_column :loan_versions, :not_approved_comment, :text
    change_column :loan_versions, :approval_expired_comment, :text
    change_column :loan_versions, :approved_change_request_comment, :text
    change_column :loan_versions, :invested_comment, :text
    change_column :loan_versions, :released_after_approval_comment, :text
    change_column :loan_versions, :not_validated_comment, :text
  end
end
