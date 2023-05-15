# frozen_string_literal: true

module Settings
  class DeletedItemsController < ApplicationController
    before_action :set_models, only: %i[index show]
    before_action :set_record, only: %i[show restore destroy]

    MODELS = %w[bond country country_group currency currency_rate default_limit limit_exception
                loan_type institution institution_group institution_type institution_covenant
                pool repayment_type status pool_document pool_legal_document].freeze

    def index; end

    def show; end

    def restore
      if @record.restore(recursive: true, recovery_window: 2.minutes)
        redirect_to fund_settings_recycle_bin_path, notice: 'Record restored with success'
      else
        flash.now[:alert] = 'Couldn\'t restore record.'
        redirect_to fund_settings_recycle_bin_path
      end
    end

    def destroy
      begin
        if @record.really_destroy!
          redirect_to fund_settings_recycle_bin_path, notice: "Record destroyed with success"
        else
          flash.now[:alert] = "Couldn't destroy record."
          redirect_to fund_settings_recycle_bin_path
        end
      rescue => e
        message = e.message
        message = @record.name + " is linked to " + e.message.scan(/dbo.(.*)\"/).last.first if e.message.include? "fk_rails"
        redirect_to fund_settings_recycle_bin_path, notice: "Couldn't destroy record: " + message
      end
    end

    private

    def set_models
      authorize :deleted_item
      @models = MODELS

      # Load records for each model into an instance variable
      @models.each do |model|
        if [PoolDocument, PoolLegalDocument].include?(model.classify.constantize)
          instance_variable_set("@#{model.pluralize}", model.classify.constantize.only_deleted.select { |o|
                                                         o.deleted_parent.nil?
                                                       }.select { |o| o.pool.fund_id == params[:fund_id].to_i })
        elsif model.classify.constantize == CurrencyRate
          instance_variable_set("@#{model.pluralize}", model.classify.constantize.only_deleted.select { |o|
                                                         o.deleted_parent.nil?
                                                       }.select { |o| o.currency.fund_id == params[:fund_id].to_i })

        else
          instance_variable_set("@#{model.pluralize}", model.classify.constantize.only_deleted.select { |o|
                                                         o.deleted_parent.nil?
                                                       }.select { |o| o.fund_id == params[:fund_id].to_i })
        end
      end
    end

    def set_record
      record_type = params[:record_type]
      record_id = params[:record_id]

      unless MODELS.include?(record_type)
        flash.now[:alert] = "Unauthorized record"
        redirect_to fund_settings_recycle_bin_url and return
      end

      authorize :deleted_item
      @record = record_type.classify.constantize.only_deleted.find(record_id)
    end
  end
end
