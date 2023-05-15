# frozen_string_literal: true

class CreateInstitutionProvisionInteractor
  include Interactor

  def call
    Loan.transaction do
      check_loans_to_provision
      create_institution_provision
      create_loans_provisions
      send_notification
    rescue Interactor::Failure => e
      raise e
    rescue StandardError => e
      context.fail!(error_message: e.message)
    end
  end

  delegate :institution, :user, :provision_percentage, :comment, to: :context

  private

  attr_reader :institution_provision, :repayment_lines_to_provision

  def check_loans_to_provision
    repayment_lines_to_provision = RepaymentCalendarLine.for_loans(institution.loans.invested.map(&:id)).pending_status.principal

    if repayment_lines_to_provision.empty?
      context.fail!(error_message: 'No repayment line to provision in this institution')
    end
  end

  def create_institution_provision
    current_provision_percentage = institution.current_provision_percentage

    @institution_provision = InstitutionProvision.create!(
      percentage: provision_percentage,
      version_status: provision_version_status,
      comment: comment,
      previous_percentage_of_provision: current_provision_percentage,
      new_percentage_of_provision: provision_percentage,
      creation_user: user,
      institution: institution
    )
  end

  def provision_version_status
    if user.administrator? || user.general_manager?
      InstitutionProvision::VERSION_STATUS_VALIDATED
    else
      InstitutionProvision::VERSION_STATUS_TEMPORARY
    end
  end

  def create_loans_provisions
    return if institution_provision.version_status != InstitutionProvision::VERSION_STATUS_VALIDATED

    institution.loans.invested.each do |loan|
      repayment_lines_to_provision = RepaymentCalendarLine.for_loan(loan).pending_status.principal
      if repayment_lines_to_provision.any?

        previous_amount_of_provision = loan.provision_amount
        new_amount_of_provision = (loan.gross_position_value * provision_percentage)

        loan_version = loan.build_new_version_with_calendar(versioning_params.merge({ provision_date: Date.today }),
                                                            versioning_params)

        new_calendar = loan_version.repayment_calendar
        new_calendar.save!

        LoanProvision.create!(
          percentage: provision_percentage,
          amount: new_amount_of_provision,
          previous_amount_of_provision: previous_amount_of_provision,
          new_amount_of_provision: new_amount_of_provision,
          loan: loan,
          institution_provision: institution_provision,
          creation_user: user,
          repayment_calendar: new_calendar
        )

        calendar_log = CalendarLog.create!(
          repayment_calendar: new_calendar,
          creation_user: user
        )

        repayment_lines_to_provision.each do |repayment_line|
          provision_to_add = repayment_line.original_amount * provision_percentage
          old_provision = repayment_line.provision
          new_provision = provision_to_add

          new_line = new_calendar.repayment_calendar_lines.detect { |line|
            line.previous_version_line_id == repayment_line.id
          }
          new_line.provision = new_provision

          CalendarLogLine.create!(
            calendar_log: calendar_log,
            action: CalendarLogLine::ACTION_INSTITUTION_PROVISION,
            original_repayment_line: repayment_line,
            changed_attribute: 'provision',
            original_value: old_provision,
            new_value: new_provision,
            new_repayment_line: new_line
          )
        end

        gross_position_value = new_calendar.temp_gross_amount
        loan_version.gross_position_value = gross_position_value
        provision_value = new_calendar.temp_provision_amount
        loan_version.provision_value = provision_value
        loan_version.net_position_value = gross_position_value - provision_value

        new_calendar.save!
        loan_version.save!
        loan.save!
      end
    end
  end

  def send_notification
    admmin_managers = User.with_any_role(User::ROLE_ADMINISTRATOR, User::ROLE_GENERAL_MANAGER)
    ims = institution.im_group.users

    admmin_managers.each do |admmin_manager|
      next if admmin_manager == user

      InstitutionMailer.institution_provision_update(institution_provision,
                                                     admmin_manager,
                                                     user.administrator? || user.general_manager?).deliver_later
    end

    ims.each do |im|
      next if im == user

      InstitutionMailer.institution_provision_update(institution_provision, im, user.administrator? || user.general_manager?).deliver_later
    end
  end

  def versioning_params
    if user.administrator? || user.general_manager?
      { version_status: LoanVersion::VERSION_STATUS_VALIDATED, validation_user: user }
    else
      { version_status: LoanVersion::VERSION_STATUS_TEMPORARY, validation_user: nil }
    end
  end
end
