module Settings
  class PoolDocumentsController < SettingsController
    before_action :get_pool
    before_action :set_setting_collection, only: [:index, :new, :show, :edit]

    def index
      :new
    end

    def new
      @pool_document = pool.pool_documents.build
      authorize @pool_document
    end

    def create
      generate_pool_document
    end

    def preview
      get_pool
      @setting = pool.pool_documents.find_by(slug: params[:pool_document_slug])
      authorize(setting)
      send_data setting.document.read, filename: setting.original_filename, disposition: :inline
    end

    def resource_class
      PoolDocument
    end

    private

    attr_reader :pool, :pool_document

    helper_method :pool, :pool_document, :pool_documents

    def collect
      @setting_collection = policy_scope(pool.pool_documents.all) # .order(:name)
    end

    def get_pool
      @pool = Pool
              .find(params[:pool_id])
      # .decorate
    end

    def pool_documents
      @pool_documents ||= pool.decorate.pool_documents_by_name
    end

    def setting_params
      params.require(:pool_document).permit(:document, :original_filename)
    end

    def after_update_path
      fund_settings_pool_pool_documents_path(id: setting.pool)
    end

    def generate_pool_document
      @pool_document = pool.pool_documents.build(setting_params)
      authorize pool_document
      if pool_document.save
        redirect_to fund_settings_pool_pool_documents_path(id: pool.id)
      else
        render :new
      end
    end

    def set_setting
      get_pool
      @setting = pool.pool_documents.find_by(slug: params[:slug])
      authorize(setting)
    end
  end
end
