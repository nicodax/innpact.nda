# frozen_string_literal: true

namespace :daily_task do
  logger = Logger.new('./log/daily_task.log')
  logger.formatter = Logger::Formatter.new
  desc 'Update automatically the status of invested loans to matured if the maturity date is passed.'
  task update_status_invested_to_matured: :environment do
    logger.info 'Start daily_task:update_status_invested_to_matured task'
    loan_to_be_updated = Loan.maturity_date_was_yesterday
    loan_successfully_updated = []
    loan_automatic_status_update_failed = []
    if loan_to_be_updated.present?
      loan_to_be_updated.each do |loan|
        active_loan_version_id = loan.active_loan_version.id
        context = update_loan_status_from_invested_to_matured(loan, LoanVersion::STATUS_MATURED)
        if context.success?
          loan_successfully_updated.push(context.loan.active_loan_version.id)
          logger.info("#{loan.id} status has been successfully updated to matured")
        else
          loan_automatic_status_update_failed.push(
            {
              loan_version_id: active_loan_version_id,
              errors: context.error.to_s
            }
          )
          logger.error("#{loan.id} status has failed to be updated to matured: #{context.error}")
        end
      end
      send_summary_email_to_admins_and_gms(loan_successfully_updated, LoanVersion::STATUS_MATURED)

      unless loan_automatic_status_update_failed.compact.empty?
        send_status_fail_summary_email_to_admins_and_gms(
          loan_automatic_status_update_failed,
          LoanVersion::STATUS_MATURED
        )
      end
    end
    logger.info('Finish daily_task:update_status_invested_to_matured task')
  end
end

def send_summary_email_to_admins_and_gms(loan_successfully_updated, new_loan_status)
  return if loan_successfully_updated.compact.empty?

  managers = User.with_any_role(User::ROLE_ADMINISTRATOR, User::ROLE_GENERAL_MANAGER)
  managers.each do |manager|
    LoanMailer.system_loan_update(loan_successfully_updated, new_loan_status, manager).deliver_now
  end
end

def update_loan_status_from_invested_to_matured(loan, new_loan_status)
  new_loan_version = LoanVersion.where(loan_id: loan.id).with_version_number(loan[:last_loan_version]).first
  new_loan_version[:status] = new_loan_status
  UpdateLoanInteractor.call(
    loan: loan,
    params: {
      loan_version: { status: new_loan_version[:status] }
    },
    user: User.system.first
  )
end

def send_status_fail_summary_email_to_admins_and_gms(loan_automatic_status_update_failed, new_loan_status)
  return if loan_automatic_status_update_failed.empty?

  managers = User.with_any_role(User::ROLE_ADMINISTRATOR, User::ROLE_GENERAL_MANAGER)
  managers.each do |manager|
    LoanMailer.system_loan_status_update_failed(loan_automatic_status_update_failed, new_loan_status, manager).deliver_now
  end
end
