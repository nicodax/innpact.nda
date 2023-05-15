# frozen_string_literal: true

module Settings
  class InstitutionGeneralController < ApplicationController
    include FundScoped

    def edit
      load_models
    end

    def update_profile
      load_models_institution

      institution_params_edited = institution_params
      institution_params_edited[:watchlist_reason] = nil unless institution_params_edited[:in_watchlist] == 'true'

      if @institution.update(institution_params_edited)
        redirect_to fund_settings_institution_path(fund_id: @institution.fund.id, id: @institution.id)
      else
        flash.now[:alert] = @institution.errors.full_messages
        @institution_rating = @institution.institution_ratings.order(as_of: :desc, updated_at: :desc).first_or_initialize
        render :edit
      end
    end

    def update_rating
      load_models
      rating = @institution.institution_ratings.order(as_of: :desc, updated_at: :desc).first

      new_rating = @institution.institution_ratings.build(rating_params)
      new_rating[:user_id] = current_user.id

      if Institution.is_current_as_of_more_recent?(rating.try(:as_of), rating_params[:as_of])
        flash.now[:alert] = "Current rating data is more recent than the currently provided"
        @institution_rating = new_rating
        render :edit
      elsif new_rating.save
        redirect_to fund_settings_institution_path(fund_id: @institution.fund.id, id: @institution.id)
      else
        flash.now[:alert] = new_rating.errors.full_messages
        @institution_rating = new_rating
        render :edit
      end
    end

    private

    def load_models_institution
      @institution = fund.institutions.find(params[:institution_id])
      authorize @institution, policy_class: InstitutionSubentityPolicy
    end

    def load_models
      @institution = fund.institutions.find(params[:institution_id])
      authorize @institution, policy_class: InstitutionSubentityPolicy
      @institution_rating = @institution.institution_ratings.order(as_of: :desc, updated_at: :desc).first_or_initialize
    end

    def rating_params
      params
        .require(:institution_rating)
        .permit(%I[as_of external_rating external_rating_agency internal_credit_risk_rating probability_of_default])
    end

    def institution_params
      params
        .require(:institution)
        .permit(%I[
                  im_group_id
                  country_id
                  institution_group_id
                  institution_type_id
                  tier
                  regulatory_status
                  cpps_adoption
                  use_of_standard_reporting_tools
                  in_watchlist
                  watchlist_reason
                ])
    end

    # def profile_params
    #   params
    #     .require(:institution_profile)
    #     .permit(%I[as_of tier regulatory_status cpps_adoption use_of_standard_reporting_tools])
    # end
  end
end
