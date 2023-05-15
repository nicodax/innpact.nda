module Settings
  class PoolLegalDocumentsController < SettingsController
    before_action :get_pool
    before_action :set_setting_collection, only: [:index, :new, :show, :edit]

    def index
      :new
    end

    def new
      @pool_legal_document = pool.pool_legal_documents.build
      authorize @pool_legal_document
    end

    def create
      if generate_pool_legal_document
        redirect_to fund_settings_pool_pool_legal_documents_path(id: pool.id)
      else
        render :new
      end
    end

    def update
      if legal_document.update_attributes(setting_params)
        redirect_to fund_settings_pool_pool_legal_documents_path(id: pool.id),
                    notice: t("settings_crud.setting_success_update", setting_name: resource_name)
      else
        flash.now[:alert] = t("settings_crud.setting_error_update", setting_name: resource_name.downcase)
        set_setting_collection
        render :edit
      end
    end

    def preview
      get_pool
      @setting = pool.pool_legal_documents.find_by(slug: params[:pool_legal_document_slug])
      authorize(setting)
      send_data setting.document.read, filename: setting.original_filename, disposition: :inline
    end

    def resource_class
      PoolLegalDocument
    end

    private

    attr_reader :pool, :pool_legal_document

    helper_method :pool, :pool_legal_document, :pool_legal_documents

    def collect
      @setting_collection = policy_scope(pool.pool_legal_documents.all) # .order(:name)
    end

    def get_pool
      @pool = fund.pools
                  .find(params[:pool_id])
                  .decorate
    end
    # def set_setting
    #   @setting = fund.pools.instance_eval(resource_attribute_name).find(params[:id])
    #   authorize(setting)
    # end

    def pool_legal_documents
      @pool_legal_documents ||= pool.pool_legal_documents_desc
    end

    def legal_document
      @legal_document = PoolLegalDocument.find_by(slug: params[:slug])
    end

    def setting_params
      params.require(:pool_legal_document).permit(:document, :original_filename)
    end

    def after_update_path
      fund_settings_pool_path(id: setting.pool)
    end

    def generate_pool_legal_document
      @pool_legal_document = pool.pool_legal_documents.build(setting_params)
      authorize pool_legal_document
      pool_legal_document.save
    end

    def set_setting
      get_pool
      @setting = pool.pool_legal_documents.find_by(slug: params[:slug])
      authorize(setting)
    end
  end
end
