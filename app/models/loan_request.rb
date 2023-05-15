# frozen_string_literal: true

class LoanRequest < ApplicationRecord
  acts_as_paranoid # soft delete

  MFI_PAYS_OPTION_FIXED_FIXED = "fixed_fixed"
  MFI_PAYS_OPTION_FIXED_FLOATING = "fixed_floating"
  MFI_PAYS_OPTION_FLOATING_FLOATING = "floating_floating"

  MFI_PAYS_OPTIONS = [MFI_PAYS_OPTION_FIXED_FIXED, MFI_PAYS_OPTION_FIXED_FLOATING, MFI_PAYS_OPTION_FLOATING_FLOATING]

  INTERMEDIARY_OPTION_DIRECT = "direct"
  INTERMEDIARY_OPTION_MSME_BOND = "msme_bond"
  INTERMEDIARY_OPTION_SYNDICATION = "syndication"
  INTERMEDIARY_OPTIONS = [INTERMEDIARY_OPTION_DIRECT, INTERMEDIARY_OPTION_MSME_BOND, INTERMEDIARY_OPTION_SYNDICATION]

  HEDGE_STRUCTURE_OPTION_INTEREST_RATE = "interest_rate"
  HEDGE_STRUCTURE_OPTION_CROSS_CCY = "cross_ccy"
  HEDGE_STRUCTURE_OPTION_INTEREST_CROSS = "interest_cross"
  HEDGE_STRUCTURE_OPTIONS = [HEDGE_STRUCTURE_OPTION_INTEREST_RATE, HEDGE_STRUCTURE_OPTION_CROSS_CCY,
                             HEDGE_STRUCTURE_OPTION_INTEREST_CROSS]

  belongs_to :user
  belongs_to :fund
  belongs_to :institution, optional: true
  belongs_to :currency, optional: true
  belongs_to :repayment_type, optional: true
  belongs_to :loan_type, optional: true
  belongs_to :assigned_investment_manager, optional: true, class_name: "User"

  has_many :loan_request_documents, dependent: :destroy
  accepts_nested_attributes_for :loan_request_documents, allow_destroy: true

  def name
    ["INNPACT LOAN #{innpact_loan_id}", institution.try(:name)].compact.join(' - ')
  end

  def valid_for_submission?
    LoanRequestToSubmit.new.call(attributes).success?
  end
end
