namespace :fill_approved_bond_and_interest_type do
  desc "Fill in the missing fields in the database"
  task fill: :environment do
    Rails.logger.info("fill_approved_bond_and_interest_type:fill tasks has started")
    loan_versions_status_approved = LoanVersion.where(status: LoanVersion::STATUS_APPROVED)
    loan_versions_status_invested_matured = LoanVersion.where(status: [LoanVersion::STATUS_INVESTED, LoanVersion::STATUS_MATURED])

    loan_versions_status_approved.each do |lv|
      loan_versions_approved_bond_id_logic(lv)
      loan_versions_approved_interest_rate_type_id_logic(lv)
      lv.save
    end

    loan_versions_status_invested_matured.each do |lv|
      loan_versions_executed_bond_id_logic(lv)
      loan_versions_executed_interest_rate_type_id_logic(lv)
      lv.save
    end
    Rails.logger.info("fill_approved_bond_and_interest_type:fill tasks has finished")
  end

  def loan_versions_approved_bond_id_logic(loan_version)
    return unless loan_version.approved_bond_id.nil? || !loan_version.executed_bond_id.nil?

    if loan_version.approved_bond_id.nil? && !loan_version.executed_bond_id.nil?
      loan_version.approved_bond_id = loan_version.executed_bond_id
      loan_version.executed_bond_id = nil
    elsif !loan_version.approved_bond_id.nil? && !loan_version.executed_bond_id.nil?
      if loan_version.approved_bond_id == loan_version.executed_bond_id
        loan_version.executed_bond_id = nil
      else
        Rails.logger.error "Approved Loan Version with ID #{loan_version.id} has an executed_bond_id = #{loan_version.executed_bond_id} and the approved_bond_id = #{loan_version.approved_bond_id}"
      end
    else
      Rails.logger.error "Approved Loan Version with ID #{loan_version.id} has an executed_bond_id = #{loan_version.executed_bond_id} and the approved_bond_id = #{loan_version.approved_bond_id}"
    end
  end

  def loan_versions_approved_interest_rate_type_id_logic(loan_version)
    return unless loan_version.approved_interest_rate_type_id.nil? || !loan_version.loan_interest_rate_type_id.nil?

    if loan_version.approved_interest_rate_type_id.nil? && !loan_version.loan_interest_rate_type_id.nil?
      loan_version.approved_interest_rate_type_id = loan_version.loan_interest_rate_type_id
      loan_version.loan_interest_rate_type_id = nil
    elsif !loan_version.approved_interest_rate_type_id.nil? && !loan_version.loan_interest_rate_type_id.nil?
      if loan_version.approved_interest_rate_type_id == loan_version.loan_interest_rate_type_id
        loan_version.loan_interest_rate_type_id = nil
      else
        Rails.logger.error "Approved Loan Version with ID #{loan_version.id} has an loan_interest_rate_type_id = #{loan_version.loan_interest_rate_type_id} and the approved_interest_rate_type_id = #{loan_version.approved_interest_rate_type_id}"
      end
    else
      Rails.logger.error "Approved Loan Version with ID #{loan_version.id} has an loan_interest_rate_type_id = #{loan_version.loan_interest_rate_type_id} and the approved_interest_rate_type_id = #{loan_version.approved_interest_rate_type_id}"
    end
  end

  def loan_versions_executed_bond_id_logic(loan_version)
    return unless loan_version.approved_bond_id.nil? || loan_version.executed_bond_id.nil?

    if loan_version.approved_bond_id.nil? && !loan_version.executed_bond_id.nil?
      loan_version.approved_bond_id = loan_version.executed_bond_id
    elsif !loan_version.approved_bond_id.nil? && loan_version.executed_bond_id.nil?
      loan_version.executed_bond_id = loan_version.approved_bond_id
    else
      Rails.logger.error "Loan Version with ID #{loan_version.id} and status #{loan_version.status} has an executed_bond_id = #{loan_version.executed_bond_id} and the approved_bond_id = #{loan_version.approved_bond_id}"
    end
  end

  def loan_versions_executed_interest_rate_type_id_logic(loan_version)
    return unless loan_version.approved_interest_rate_type_id.nil? || loan_version.loan_interest_rate_type_id.nil?

    if loan_version.approved_interest_rate_type_id.nil? && !loan_version.loan_interest_rate_type_id.nil?
      loan_version.approved_interest_rate_type_id = loan_version.loan_interest_rate_type_id
    elsif !loan_version.approved_interest_rate_type_id.nil? && loan_version.loan_interest_rate_type_id.nil?
      loan_version.loan_interest_rate_type_id = loan_version.approved_interest_rate_type_id
    else
      Rails.logger.error "Loan Version with ID #{loan_version.id} and status #{loan_version.status} has an loan_interest_rate_type_id = #{loan_version.loan_interest_rate_type_id} and the approved_interest_rate_type_id = #{loan_version.approved_interest_rate_type_id}"
    end
  end
end
