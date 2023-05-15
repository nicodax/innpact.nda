# Preview all emails at http://localhost:3000/rails/mailers/loan_mailer
class LoanMailerPreview < ActionMailer::Preview
  # Preview this email at http://localhost:3000/rails/mailers/loan_mailer/loan_update_without_validation_link
  def loan_update_without_validation_link
    LoanMailer.loan_update_without_validation_link(LoanVersion.last.id)
  end
end
