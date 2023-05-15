class CreateLoanRequestDocuments < ActiveRecord::Migration[6.0]
  def change
    create_table :loan_request_documents do |t|
      t.references :loan_request, null: false
      t.string :document, null: false
      t.string :original_filename
      t.string :slug
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
