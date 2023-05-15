# frozen_string_literal: true

class LoanProvision < ApplicationRecord
  acts_as_paranoid

  belongs_to :institution_provision, optional: true
  belongs_to :creation_user, class_name: "User"
  belongs_to :loan
  belongs_to :repayment_calendar

  validate :provision_lower_than_gpv

  def provision_lower_than_gpv
    if new_amount_of_provision > repayment_calendar.temp_gross_amount
      errors.add(:new_amount_of_provision, I18n.t("loan_provisions.errors.amount_of_provision_cannot_exceed_loan_gpv"))
    end
  end
end
