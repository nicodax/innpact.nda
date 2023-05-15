module Api
  class LoanValuesImportsController < ApiController
    def create
      importer = get_importer
      importer.process

      if importer.errors.any?
        render json: { errors: importer.errors }, status: :bad_request
      else
        render json: { data_to_import: importer.data_to_import }, status: :ok
      end
    end

    private

    def get_importer
      if params[:mode] == "status"
        LoanStatusDataImporter.new(params[:file], fund)
      elsif params[:mode] == "assigned_loan"
        AssignedLoanImporter.new(params[:file], fund)
      end
    end

    def fund
      Fund.find(params[:fund_id])
    end
  end
end
