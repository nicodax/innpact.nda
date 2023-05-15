# frozen_string_literal: true

class CreateInstitutionInteractor
  include Interactor

  def call
    Institution.transaction do
      create_institution_object
      # It was requested by the Client to import liabilities and assets upon creation of the institution
      # It appears to not be the case anymore, let's wait and see. AFR, 14/01/2021
      # It is needed during the update (under certain conditions) in the update_institution_interactor
      # import_liabilities_and_assets
    rescue Interactor::Failure => e
      context.fail!(error: e.context.error)
    rescue ActiveRecord::RecordInvalid => e
      context.fail!(error: e.record.errors.full_messages)
      # rescue StandardError => e
      #   ActiveSupport::Notifications.instrument 'exception.interactors',
      #                                           exception: e,
      #                                           interactor: :create_institution,
      #                                           backtrace: e.backtrace
      #   context.fail!(error: I18n.t('institutions.create.error'))
    end
  end

  delegate :institution_params, :setting, :file, :fund, to: :context

  private

  def create_institution_object
    institution_params["name"] = institution_params["name"].strip unless institution_params["name"].nil?
    context.setting = fund.institutions.new(institution_params)

    setting.save!

    earliest_as_of = [institution_params['financials_as_of_date'], institution_params['portfolio_breakdown_i_as_of_date'], institution_params['clients_as_of_date']].min
    institution_profile_params = {
      institution_id: setting.id,
      as_of: earliest_as_of.try(:to_datetime) || DateTime.now,
      tier: institution_params.fetch('tier', nil)
    }
    institution_financials_params = {
      institution_id: setting.id,
      as_of: institution_params.fetch('financials_as_of_date', nil),
      total_assets: institution_params.fetch('total_assets', nil),
      gross_loan_portfolio: institution_params.fetch('gross_loan_portfolio', nil),
      equity: institution_params.fetch('equity', nil),
      net_income: institution_params.fetch('net_income', nil),
      liabilities: institution_params.fetch('liabilities', nil)
    }
    institution_specific_breakdown_params = {
      institution_id: setting.id,
      as_of: institution_params.fetch('portfolio_breakdown_i_as_of_date', nil),
      microfinance_portfolio_size: institution_params.fetch('microfinance_portfolio_size', nil),
      sme_portfolio_size_under_35k: institution_params.fetch('sme_portfolio_size_under_35k', nil)
    }
    institution_impact_indicators_params = {
      institution_id: setting.id,
      as_of: institution_params.fetch('clients_as_of_date', nil),
      borrowers_count: institution_params.fetch('borrowers_count', nil),
      female_borrowers_count: institution_params.fetch('female_borrowers_count', nil),
      avg_loan_size: institution_params.fetch('avg_loan_size', nil)
    }

    InstitutionProfile.create!(institution_profile_params)
    InstitutionFinancial.create!(institution_financials_params) unless institution_financials_params.values.count(&:present?) == 1 # Only setting_id is present
    InstitutionSpecificBreakdown.create!(institution_specific_breakdown_params) unless institution_specific_breakdown_params.values.count(&:present?) == 1
    InstitutionImpactIndicator.create!(institution_impact_indicators_params) unless institution_impact_indicators_params.values.count(&:present?) == 1
  end

  # def import_liabilities_and_assets
  #   begin
  #     if file.nil?
  #       raise I18n.t("settings.institutions.upload.upload_calendar_file")
  #     end
  #     AssetsAndLiabilitiesImporter.import_file(file, setting.id)
  #   rescue => e
  #     context.fail!(error: e.message)
  #   end
  # end
end
