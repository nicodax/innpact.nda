Rails.application.routes.draw do
 devise_for :users, controllers: {
    sessions: 'users/sessions',
    passwords: 'users/passwords',
    registrations: 'users/registrations'
  }

  root to: 'user_dashboard#show'

  namespace :api do
    post "loan_values_imports", to: "loan_values_imports#create"
    get "currency_rates", to: "currency_rates#index"
  end

  resource :user_dashboard, only: [:show]
  #fix not too pretty from https://stackoverflow.com/questions/30659572/change-the-name-of-parent-parent-id-parameter-in-routing-resources-for-rails4
  resources :funds, param: :fund_id do
    get "inactive", to: "inactive_funds#index", as: :inactive, on: :collection#, params: :fund_id
    get "deleted", to: "deleted_funds#index", as: :deleted, on: :collection#, params: :fund_id
  end
  resources :funds, only: [], param: :id do
    put "archive", to: "funds#archive", as: :archive#, params: :fund_id
    put "enable", to: "funds#enable", as: :enable#, params: :fund_id
    get "inactive/:id", to: "inactive_funds#show", as: :show_inactive, on: :collection#, params: :fund_id
    # Might refactor these routes using resources, maybe TODO later
    get "deleted/:id", to: "deleted_funds#show", as: :show_deleted, on: :collection#, params: :fund_id
    put "deleted/:id", to: "deleted_funds#restore", as: :restore_deleted, on: :collection#, params: :fund_id
    delete "deleted/:id", to: "deleted_funds#destroy", as: :destroy_deleted, on: :collection#, params: :fund_id
		resources :fund_usd_amounts, only: [:new, :create]
		resource :loan_request_dashboard, only: [:show, :create]
		resource :accepted_loan_dashboard, only: [:show, :create]
		resource :matured_loan_dashboard, only: [:show, :create]
		resource :critical_case_dashboard, only: [:show, :create]
		resources :loans do
      resource :rollback_to_invested, only: [:update]
      resource :create_loan_tranche, only: [:create]
		  resources :versions, only: [] do
		    resource :validation, only: [:show, :create], controller: :loan_version_validations
			end
			resource :repayment_calendar_dashboards
			resource :repayment_calendar, only: [ :edit, :update ] do
        resource :validation, only: [:create], controller: :repayment_calendar_validations
			end
		end
    resources :deleted_loans, only: [:index, :update, :show]
    resource :loan_batches, only: [:destroy, :update]
		resources :loan_exports, only: [:create]
    get '/settings', to: "settings#index",as: :settings
    namespace :settings do
      resources :limits
      resources :default_limits
      resources :exception_limits
      resources :repayment_types
      resources :statuses
      resources :loan_types
      resources :country_groups
      resources :bonds
      resources :covenants
      resources :interest_rate_types
      resources :institution_groups
      resources :institution_types
      resources :im_groups
      resources :countries do
        collection {post :import}
        collection {get :upload}
      end
      resources :currencies do
        collection {post :import}
        collection {get :upload}

        resources :currency_rates
      end
      resources :pools do
        resources :pool_targets
        resources :pool_documents, param: :slug do
          get "/preview", to: "pool_documents#preview", as: :preview
        end
        resources :pool_legal_documents, param: :slug do
          get "/preview", to: "pool_legal_documents#preview", as: :preview
        end
      end
      resources :institutions do
        # collection {post :import}
        # collection {get :upload}
        post "/:id/import", to: "institutions#import", as: :import, on: :collection
        get "/:id/upload", to: "institutions#upload", as: :upload, on: :collection

        resources :institution_assets
        resources :institution_covenants
        resources :institution_esg_sdg_contribution
        resources :institution_esg_gender_equality
        resources :institution_esg_safeguard
        resources :institution_esg_risk
        resources :institution_esg_pai_indicator
        resources :institution_liabilities
        resources :institution_provisions, only: [:create] do
          post :validate, on: :member
        end

        get 'institution_general/edit', to: 'institution_general#edit'
        post 'institution_general/update_profile'
        get 'institution_general/update_profile', to: 'institution_general#edit'
        post 'institution_general/update_rating'
        get 'institution_general/update_rating', to: 'institution_general#edit'

        get 'institution_financial/edit', to: 'institution_financial#edit'
        post 'institution_financial', to: 'institution_financial#update'
        get 'institution_financial', to: 'institution_financial#edit'

        get 'institution_specific_breakdown/edit', to: 'institution_specific_breakdown#edit'
        post 'institution_specific_breakdown/update_specific_breakdowns'
        get 'institution_specific_breakdown/update_specific_breakdowns', to: 'institution_specific_breakdown#edit'
        post 'institution_specific_breakdown/update_distribution_by_sector'
        get 'institution_specific_breakdown/update_distribution_by_sector', to: 'institution_specific_breakdown#edit'
        post 'institution_specific_breakdown/update_distribution_by_loan_purpose'
        get 'institution_specific_breakdown/update_distribution_by_loan_purpose', to: 'institution_specific_breakdown#edit'
        
        get 'institution_positive_impact/edit', to: 'institution_positive_impact#edit'
        post 'institution_positive_impact/update_alinus_result'
        get 'institution_positive_impact/update_alinus_result', to: 'institution_positive_impact#edit'
        post 'institution_positive_impact/update_gender_equality'
        get 'institution_positive_impact/update_gender_equality', to: 'institution_positive_impact#edit'
        post 'institution_positive_impact/update_services_offered'
        get 'institution_positive_impact/update_services_offered', to: 'institution_positive_impact#edit'
        post 'institution_positive_impact/update_impact_indicator'
        get 'institution_positive_impact/update_impact_indicator', to: 'institution_positive_impact#edit'

        get 'institution_esg/edit', to: 'institution_esg#edit'
        post 'institution_esg/update_safeguard'
        get 'institution_esg/update_safeguard', to: 'institution_esg#edit'
        post 'institution_esg/update_risk'
        get 'institution_esg/update_risk', to: 'institution_esg#edit'

        get 'institution_principal_adverse/edit', to: 'institution_principal_adverse#edit'
        post 'institution_principal_adverse/update_pai_indicator'
        get 'institution_principal_adverse/update_pai_indicator', to: 'institution_principal_adverse#edit'
        post 'institution_principal_adverse/update_environment_pai'
        get 'institution_principal_adverse/update_environment_pai', to: 'institution_principal_adverse#edit'
        post 'institution_principal_adverse/delete_environment_pai'
        get 'institution_principal_adverse/delete_environment_pai', to: 'institution_principal_adverse#edit'
        post 'institution_principal_adverse/update_social_pai'
        get 'institution_principal_adverse/update_social_pai', to: 'institution_principal_adverse#edit'
        post 'institution_principal_adverse/delete_social_pai'
        get 'institution_principal_adverse/delete_social_pai', to: 'institution_principal_adverse#edit'
      end

      get "recycle_bin", to: "deleted_items#index", as: :recycle_bin
      # Single item
      put "recycle_bin/:record_type/:record_id", to: "deleted_items#restore", as: :restore_deleted_item
      delete "recycle_bin/:record_type/:record_id", to: "deleted_items#destroy", as: :destroy_deleted_item
      # Selected items
      put "recycle_bin/restore_items", to: "selected_deleted_items#restore", as: :restore_selected_deleted_items
      delete "recycle_bin/destroy_items", to: "selected_deleted_items#destroy", as: :destroy_selected_deleted_items

      resource :funds_users, only: [:show, :update]
    end
  end

  get '/settings', to: "settings#index",as: :settings
  namespace :settings do
    resources :users
    resources :deleted_users, only: [:index, :show, :destroy] do
      put "restore", to: "deleted_users#restore", as: :restore, on: :member
    end
  end

  resource :profile, only: [:show, :edit, :update]
end
