class AddCommentsToLoanVersion < ActiveRecord::Migration[6.0]
  def change
    add_column :loan_versions, :pending_ratification_comment, :string, limit: 1000
    add_column :loan_versions, :ratified_comment, :string, limit: 1000
    add_column :loan_versions, :not_ratified_comment, :string, limit: 1000
    add_column :loan_versions, :assignement_expired_comment, :string, limit: 1000
    add_column :loan_versions, :released_before_approval_comment, :string, limit: 1000
    add_column :loan_versions, :pending_approval_comment, :string, limit: 1000
    add_column :loan_versions, :approved_comment, :string, limit: 1000
    add_column :loan_versions, :not_approved_comment, :string, limit: 1000
    add_column :loan_versions, :approval_expired_comment, :string, limit: 1000
    add_column :loan_versions, :approved_change_request_comment, :string, limit: 1000
    add_column :loan_versions, :invested_comment, :string, limit: 1000
    add_column :loan_versions, :released_after_approval_comment, :string, limit: 1000
    add_column :loan_versions, :not_validated_comment, :string, limit: 1000
  end
end
