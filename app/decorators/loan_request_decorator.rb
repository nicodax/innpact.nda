class LoanRequestDecorator < ApplicationDecorator
  decorates LoanRequest

  def mfi_pays_options
    LoanRequest::MFI_PAYS_OPTIONS.map { |mfi_pays_option|
      [I18n.t("loan_requests.mfi_pays_options.#{mfi_pays_option}"), mfi_pays_option]
    }
  end

  def intermediary_options
    LoanRequest::INTERMEDIARY_OPTIONS.map { |intermediary_option|
      [I18n.t("loan_requests.intermediary_options.#{intermediary_option}"), intermediary_option]
    }
  end

  def hedge_structure_options
    LoanRequest::HEDGE_STRUCTURE_OPTIONS.map { |hedge_structure_option|
      [I18n.t("loan_requests.hedge_structure_options.#{hedge_structure_option}"), hedge_structure_option]
    }
  end

  def submission_validation
    @vsubmission_alidation ||= LoanRequestToSubmit.new.call(attributes)
  end

  def submission_validation_status_message
    submission_validation.success? ? I18n.t('loan_requests.ready_for_submission') : I18n.t('loan_requests.not_ready_for_submission')
  end

  def submission_validation_errors
    submission_validation.errors.map do |error|
      [I18n.t("activerecord.attributes.loan_request.#{error.path.first.to_s}"), error.text]
    end
  end

  def loan_request_documents_by_name
    loan_request_documents.sort_by { |pd| pd.updated_at }.reverse.group_by { |pd| pd.original_filename }
  end

  def fund_investment_managers
    fund.users.with_role(User::ROLE_INVESTMENT_MANAGER)
  end

  def created_at
    object.created_at.strftime("%F")
  end

  def status
    return I18n.t("loans.status.loan_request_submitted_for_ratification") if submitted_at.present?
    return I18n.t("loans.status.loan_request_not_submitted") if valid_for_submission?

    return I18n.t("loans.status.loan_request_to_complete")
  end

  def investment_manager_name
    assigned_investment_manager.try(:full_name)
  end

  def country_name
    institution.try(:country).try(:name)
  end

  def country_group_name
    (institution.try(:country).try(:country_groups) || []).map(&:name).join(',')
  end

  def institution_name
    institution.try(:name)
  end
end
